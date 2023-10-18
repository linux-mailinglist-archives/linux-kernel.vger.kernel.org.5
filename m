Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191827CD644
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjJRIUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjJRIU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:20:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF50F9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC87C433CA;
        Wed, 18 Oct 2023 08:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697617224;
        bh=TWmi1Z5nSzlL8GsKRL77jxFXt54ALrwkVztLIBKNRe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hLeCGIQaPoylt0uQ/wPtp+0aK27AkGYEl/EkSEPLMjy1/mckCKNWkWLVBg9MevASw
         1xWTVarYZJLx1fS58y0yHJa+EUq2wI7SbxiXTuIfnfASbvNUPHuqAGEy7kn8+4wX4R
         dsaqRnRtWh6fpwxjbvaPsZVMDrfuCT6XuzmqfFMmu07XKJlUzUyi9hvscTbQGTpPW6
         qUiq+pWbNhNEGLh+n6mK2r/lZgRiHroxrT5I+Zoy65qak5UIxwzp0sZ4nG3bSDlJnw
         iAWl7Pn4Jkz4vVB+PVsc6DZ663uyN4igfQpO/pgdCFyWJMT2Qv3s9CHiNSRSnzazry
         Wo1Vn6aGZkyWg==
From:   Saeed Mahameed <saeed@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 4/5] misc: mlx5ctl: Add command rpc ioctl
Date:   Wed, 18 Oct 2023 01:19:40 -0700
Message-ID: <20231018081941.475277-5-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018081941.475277-1-saeed@kernel.org>
References: <20231018081941.475277-1-saeed@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@nvidia.com>

Add new IOCTL to allow user space to send device debug rpcs and
attach the user's uctx UID to each rpc.

In the mlx5 architecture the FW RPC commands are of the format of
inbox and outbox buffers. The inbox buffer contains the command
rpc layout as described in the ConnectX Programmers Reference Manual
(PRM) document and as defined in include/linux/mlx5/mlx5_ifc.h.

On success the user outbox buffer will be filled with the device's rpc
response.

For example to query device capabilities:
a user fills out an inbox buffer with the inbox layout:
   struct mlx5_ifc_query_hca_cap_in_bits
and expects an outbox buffer with the layout:
   struct mlx5_ifc_cmd_hca_cap_bits

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/misc/mlx5ctl/main.c | 93 +++++++++++++++++++++++++++++++++++++
 include/uapi/misc/mlx5ctl.h | 13 ++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/misc/mlx5ctl/main.c b/drivers/misc/mlx5ctl/main.c
index 008ad3a12d97..5f4edcc3e112 100644
--- a/drivers/misc/mlx5ctl/main.c
+++ b/drivers/misc/mlx5ctl/main.c
@@ -233,6 +233,95 @@ static int mlx5ctl_info_ioctl(struct file *file, void __user *arg, size_t usize)
 	return err;
 }
 
+struct mlx5_ifc_mbox_in_hdr_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_mbox_out_hdr_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x40];
+};
+
+static int mlx5ctl_cmdrpc_ioctl(struct file *file, void __user *arg, size_t usize)
+{
+	struct mlx5ctl_fd *mfd = file->private_data;
+	struct mlx5ctl_dev *mcdev = mfd->mcdev;
+	struct mlx5ctl_cmdrpc *rpc = NULL;
+	void *in = NULL, *out = NULL;
+	size_t ksize = 0;
+	int err;
+
+	ksize = max(sizeof(struct mlx5ctl_cmdrpc), usize);
+	rpc = kzalloc(ksize, GFP_KERNEL_ACCOUNT);
+	if (!rpc)
+		return -ENOMEM;
+
+	err = copy_from_user(rpc, arg, usize);
+	if (err)
+		goto out;
+
+	mlx5ctl_dbg(mcdev, "[UID %d] cmdrpc: rpc->inlen %d rpc->outlen %d\n",
+		    mfd->uctx_uid, rpc->inlen, rpc->outlen);
+
+	if (rpc->inlen < MLX5_ST_SZ_BYTES(mbox_in_hdr) ||
+	    rpc->outlen < MLX5_ST_SZ_BYTES(mbox_out_hdr) ||
+	    rpc->inlen > MLX5CTL_MAX_RPC_SIZE ||
+	    rpc->outlen > MLX5CTL_MAX_RPC_SIZE) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (rpc->flags) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	in = memdup_user(u64_to_user_ptr(rpc->in), rpc->inlen);
+	if (IS_ERR(in)) {
+		err = PTR_ERR(in);
+		goto out;
+	}
+
+	out = kvzalloc(rpc->outlen, GFP_KERNEL_ACCOUNT);
+	if (!out) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	mlx5ctl_dbg(mcdev, "[UID %d] cmdif: opcode 0x%x inlen %d outlen %d\n",
+		    mfd->uctx_uid,
+		    MLX5_GET(mbox_in_hdr, in, opcode), rpc->inlen, rpc->outlen);
+
+	MLX5_SET(mbox_in_hdr, in, uid, mfd->uctx_uid);
+	err = mlx5_cmd_do(mcdev->mdev, in, rpc->inlen, out, rpc->outlen);
+	mlx5ctl_dbg(mcdev, "[UID %d] cmdif: opcode 0x%x retval %d\n",
+		    mfd->uctx_uid,
+		    MLX5_GET(mbox_in_hdr, in, opcode), err);
+
+	/* -EREMOTEIO means outbox is valid, but out.status is not */
+	if (!err || err == -EREMOTEIO) {
+		err = 0;
+		if (copy_to_user(u64_to_user_ptr(rpc->out), out, rpc->outlen))
+			err = -EFAULT;
+	}
+
+out:
+	kvfree(out);
+	kfree(in);
+	kfree(rpc);
+	return err;
+}
+
 static ssize_t mlx5ctl_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
 {
@@ -259,6 +348,10 @@ static ssize_t mlx5ctl_ioctl(struct file *file, unsigned int cmd,
 		err = mlx5ctl_info_ioctl(file, argp, size);
 		break;
 
+	case MLX5CTL_IOCTL_CMDRPC:
+		err = mlx5ctl_cmdrpc_ioctl(file, argp, size);
+		break;
+
 	default:
 		mlx5ctl_dbg(mcdev, "Unknown ioctl %x\n", cmd);
 		err = -ENOIOCTLCMD;
diff --git a/include/uapi/misc/mlx5ctl.h b/include/uapi/misc/mlx5ctl.h
index 81d89cd285fc..49c26ccc2d21 100644
--- a/include/uapi/misc/mlx5ctl.h
+++ b/include/uapi/misc/mlx5ctl.h
@@ -16,9 +16,22 @@ struct mlx5ctl_info {
 	__u32 reserved2[4];
 };
 
+struct mlx5ctl_cmdrpc {
+	__aligned_u64 in; /* RPC inbox buffer user address */
+	__aligned_u64 out; /* RPC outbox buffer user address */
+	__u32 inlen; /* inbox buffer length */
+	__u32 outlen; /* outbox buffer length */
+	__aligned_u64 flags;
+};
+
+#define MLX5CTL_MAX_RPC_SIZE 8192
+
 #define MLX5CTL_IOCTL_MAGIC 0x5c
 
 #define MLX5CTL_IOCTL_INFO \
 	_IOR(MLX5CTL_IOCTL_MAGIC, 0x0, struct mlx5ctl_info)
 
+#define MLX5CTL_IOCTL_CMDRPC \
+	_IOWR(MLX5CTL_IOCTL_MAGIC, 0x1, struct mlx5ctl_cmdrpc)
+
 #endif /* __MLX5CTL_IOCTL_H__ */
-- 
2.41.0

