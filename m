Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7153F772343
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjHGMAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjHGMAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:00:09 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E2F199D;
        Mon,  7 Aug 2023 04:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1691407286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LwOcH+rQmHN7pp/8QW0qcI7HUzfKr2ilYJPW1SB38kQ=;
        b=Ez1ku2zWi6MNM8/Xab4rEXTK/WNj8NQXkor16yAO9hVm6dxuj78PuQIsXpCgP8q0Y11Ttv
        yCJljsmej+ZUyy9G2v+WT/cFSG24w3fy7BBLF7ABkFQufIOFGJAy3nLSYy1tIKJ2HfbjJw
        QBO0XxH/MYKdyYbYFAvPJ+rGLKWKNO8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH v4 3/6] iio: buffer-dma: Enable buffer write support
Date:   Mon,  7 Aug 2023 13:21:10 +0200
Message-Id: <20230807112113.47157-4-paul@crapouillou.net>
In-Reply-To: <20230807112113.47157-1-paul@crapouillou.net>
References: <20230807112113.47157-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding write support to the buffer-dma code is easy - the write()
function basically needs to do the exact same thing as the read()
function: dequeue a block, read or write the data, enqueue the block
when entirely processed.

Therefore, the iio_buffer_dma_read() and the new iio_buffer_dma_write()
now both call a function iio_buffer_dma_io(), which will perform this
task.

Note that we preemptively reset block->bytes_used to the buffer's size
in iio_dma_buffer_request_update(), as in the future the
iio_dma_buffer_enqueue() function won't reset it.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

---
v2: - Fix block->state not being reset in
      iio_dma_buffer_request_update() for output buffers.
    - Only update block->bytes_used once and add a comment about why we
      update it.
    - Add a comment about why we're setting a different state for output
      buffers in iio_dma_buffer_request_update()
    - Remove useless cast to bool (!!) in iio_dma_buffer_io()

v3: - Reorganize arguments to iio_dma_buffer_io()
    - Change 'is_write' argument to 'is_from_user'
    - Change (__force char *) to (__force __user char *), in
      iio_dma_buffer_write(), since we only want to drop the "const".

v4: Drop iio_dma_buffer_space_available() function, and update patch
    description accordingly.
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 89 ++++++++++++++++----
 include/linux/iio/buffer-dma.h               |  2 +
 2 files changed, 75 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 764f1400a545..e00b704941b6 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -195,6 +195,18 @@ static void _iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
 		block->state = IIO_BLOCK_STATE_DONE;
 }
 
+static void iio_dma_buffer_queue_wake(struct iio_dma_buffer_queue *queue)
+{
+	__poll_t flags;
+
+	if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN)
+		flags = EPOLLIN | EPOLLRDNORM;
+	else
+		flags = EPOLLOUT | EPOLLWRNORM;
+
+	wake_up_interruptible_poll(&queue->buffer.pollq, flags);
+}
+
 /**
  * iio_dma_buffer_block_done() - Indicate that a block has been completed
  * @block: The completed block
@@ -212,7 +224,7 @@ void iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
 	spin_unlock_irqrestore(&queue->list_lock, flags);
 
 	iio_buffer_block_put_atomic(block);
-	wake_up_interruptible_poll(&queue->buffer.pollq, EPOLLIN | EPOLLRDNORM);
+	iio_dma_buffer_queue_wake(queue);
 }
 EXPORT_SYMBOL_GPL(iio_dma_buffer_block_done);
 
@@ -241,7 +253,7 @@ void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue *queue,
 	}
 	spin_unlock_irqrestore(&queue->list_lock, flags);
 
-	wake_up_interruptible_poll(&queue->buffer.pollq, EPOLLIN | EPOLLRDNORM);
+	iio_dma_buffer_queue_wake(queue);
 }
 EXPORT_SYMBOL_GPL(iio_dma_buffer_block_list_abort);
 
@@ -335,8 +347,24 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 			queue->fileio.blocks[i] = block;
 		}
 
-		block->state = IIO_BLOCK_STATE_QUEUED;
-		list_add_tail(&block->head, &queue->incoming);
+		/*
+		 * block->bytes_used may have been modified previously, e.g. by
+		 * iio_dma_buffer_block_list_abort(). Reset it here to the
+		 * block's so that iio_dma_buffer_io() will work.
+		 */
+		block->bytes_used = block->size;
+
+		/*
+		 * If it's an input buffer, mark the block as queued, and
+		 * iio_dma_buffer_enable() will submit it. Otherwise mark it as
+		 * done, which means it's ready to be dequeued.
+		 */
+		if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN) {
+			block->state = IIO_BLOCK_STATE_QUEUED;
+			list_add_tail(&block->head, &queue->incoming);
+		} else {
+			block->state = IIO_BLOCK_STATE_DONE;
+		}
 	}
 
 out_unlock:
@@ -465,20 +493,12 @@ static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
 	return block;
 }
 
-/**
- * iio_dma_buffer_read() - DMA buffer read callback
- * @buffer: Buffer to read form
- * @n: Number of bytes to read
- * @user_buffer: Userspace buffer to copy the data to
- *
- * Should be used as the read callback for iio_buffer_access_ops
- * struct for DMA buffers.
- */
-int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
-	char __user *user_buffer)
+static int iio_dma_buffer_io(struct iio_buffer *buffer, size_t n,
+			     char __user *user_buffer, bool is_from_user)
 {
 	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
 	struct iio_dma_buffer_block *block;
+	void *addr;
 	int ret;
 
 	if (n < buffer->bytes_per_datum)
@@ -501,8 +521,13 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 	n = rounddown(n, buffer->bytes_per_datum);
 	if (n > block->bytes_used - queue->fileio.pos)
 		n = block->bytes_used - queue->fileio.pos;
+	addr = block->vaddr + queue->fileio.pos;
 
-	if (copy_to_user(user_buffer, block->vaddr + queue->fileio.pos, n)) {
+	if (is_from_user)
+		ret = copy_from_user(addr, user_buffer, n);
+	else
+		ret = copy_to_user(user_buffer, addr, n);
+	if (ret) {
 		ret = -EFAULT;
 		goto out_unlock;
 	}
@@ -521,8 +546,40 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 
 	return ret;
 }
+
+/**
+ * iio_dma_buffer_read() - DMA buffer read callback
+ * @buffer: Buffer to read form
+ * @n: Number of bytes to read
+ * @user_buffer: Userspace buffer to copy the data to
+ *
+ * Should be used as the read callback for iio_buffer_access_ops
+ * struct for DMA buffers.
+ */
+int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
+	char __user *user_buffer)
+{
+	return iio_dma_buffer_io(buffer, n, user_buffer, false);
+}
 EXPORT_SYMBOL_GPL(iio_dma_buffer_read);
 
+/**
+ * iio_dma_buffer_write() - DMA buffer write callback
+ * @buffer: Buffer to read form
+ * @n: Number of bytes to read
+ * @user_buffer: Userspace buffer to copy the data from
+ *
+ * Should be used as the write callback for iio_buffer_access_ops
+ * struct for DMA buffers.
+ */
+int iio_dma_buffer_write(struct iio_buffer *buffer, size_t n,
+			 const char __user *user_buffer)
+{
+	return iio_dma_buffer_io(buffer, n,
+				 (__force __user char *)user_buffer, true);
+}
+EXPORT_SYMBOL_GPL(iio_dma_buffer_write);
+
 /**
  * iio_dma_buffer_usage() - DMA buffer data_available and
  * space_available callback
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 52a838ec0e57..6e27e47077d5 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -132,6 +132,8 @@ int iio_dma_buffer_disable(struct iio_buffer *buffer,
 	struct iio_dev *indio_dev);
 int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 	char __user *user_buffer);
+int iio_dma_buffer_write(struct iio_buffer *buffer, size_t n,
+			 const char __user *user_buffer);
 size_t iio_dma_buffer_usage(struct iio_buffer *buffer);
 int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, size_t bpd);
 int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int length);
-- 
2.40.1

