Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F3B76E8CC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbjHCMvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjHCMvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:51:52 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9E43588
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:51:50 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-31400956ce8so668182f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691067108; x=1691671908;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=386r6j4QMFbfOrIdvcLgjW0KP9NvXLmpvV5c26bmV8M=;
        b=m9ZVMP5eY+0b5z9eWP3eZHDamK+vbZ8J03CJptG9y9KX630jiL/EiWxcqk4KYB9Ixl
         +HeEuLS8YeL2OqVKNWYTX6QShao4xucTFdAtqe2s61kEFBgwIwXp7wCJ6zsn5Jc03soz
         R4vHoWcqweYalxbXx69J64Qb0V7SnChL152xScnq7pcG8WRs6pWfBAOM6P3mXJ6Oi3M1
         B5a+PuIpg01BrVv7D4M+yg968ud8fgqxDxZUkEFmTJRlGWpKFgKrCjS+qlzoMKpzdyUs
         HTRi7UgLNxg1H7Hzj81O1BWRfuAdVzebU4svc9FPJlD+sRux8LxRUO24kGEIleafqZIt
         EuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691067108; x=1691671908;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=386r6j4QMFbfOrIdvcLgjW0KP9NvXLmpvV5c26bmV8M=;
        b=iBh3AwY3tLw+z2ScS1mFvR0XDcjo1YKtRFvwSCU+MCBfox479f2EcKuDn6Ejd99Yob
         VsvsS4L1MgPQaKGRT1kjBm5RwPQDtV+MZkQXVrvvXxMLqlaMuCAUpZemIkl35fiEqiDC
         esZVbwMOO/wY6wFRL8nysytO3S+nPxVSlNn6gKeW6tWiiXW9O9zoEo5NqL0r94PA+vwE
         zrZa19qz1JnUOdNNT5EEzUlq6X10Ae9qaVOmB2BemcIozULBKl2LCsIw72WWUEmkObT2
         5/RCXJIauDUz4y4Bhui9CeykkhO/AdZkbLbKnc5d23AhuMA7XbGLERF5QYMGBj4W8uFE
         YhuQ==
X-Gm-Message-State: ABy/qLae5C+gKw8T1p5NYY5WQGAh9SV5GasG9gJNCkGj7HS93sKgJlWk
        OPf881Z/iOo+tZjiK5w0l7b7/rZvWzwqPO0D
X-Google-Smtp-Source: APBJJlEMCWM5NeRkHmGQry3+/bOgGmpHiP0VNvs210IGDy1wU9DxkGtBcvjjlQX6+zmh8gXkqO9az/JjiJ+Hl4vH
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:adf:f20a:0:b0:314:1ac7:2763 with SMTP
 id p10-20020adff20a000000b003141ac72763mr52577wro.0.1691067108515; Thu, 03
 Aug 2023 05:51:48 -0700 (PDT)
Date:   Thu,  3 Aug 2023 13:51:35 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803125137.1779474-1-vdonnefort@google.com>
Subject: [PATCH v6 0/2] Introducing trace buffer mapping by user-space
From:   Vincent Donnefort <vdonnefort@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tracing ring-buffers can be stored on disk or sent to network without any
copy via splice. However the later doesn't allow real time processing of the
traces. A solution is to give access to userspace to the ring-buffer pages
directly via a mapping. A piece of software can now become a reader of the
ring-buffer, and drive a consuming or non-consuming read in a similar fashion to
what trace and trace_pipe offer.

Attached to this cover letter an example of consuming read for a ring-buffer,
using libtracefs.

Vincent

v5 -> v6:
  * Rebase on next-20230802.
  * (unsigned long) -> (void *) cast for virt_to_page().
  * Add a wait for the GET_READER_PAGE ioctl.
  * Move writer fields update (overrun/pages_lost/entries/pages_touched)
    in the irq_work.
  * Rearrange id in struct buffer_page.
  * Rearrange the meta-page.
  * ring_buffer_meta_page -> trace_buffer_meta_page.
  * Add meta_struct_len into the meta-page.

v4 -> v5:
  * Trivial rebase onto 6.5-rc3 (previously 6.4-rc3)

v3 -> v4:
  * Add to the meta-page:
       - pages_lost / pages_read (allow to compute how full is the
	 ring-buffer)
       - read (allow to compute how many entries can be read)
       - A reader_page struct.
  * Rename ring_buffer_meta_header -> ring_buffer_meta
  * Rename ring_buffer_get_reader_page -> ring_buffer_map_get_reader_page
  * Properly consume events on ring_buffer_map_get_reader_page() with
    rb_advance_reader().

v2 -> v3:
  * Remove data page list (for non-consuming read)
    ** Implies removing order > 0 meta-page
  * Add a new meta page field ->read
  * Rename ring_buffer_meta_page_header into ring_buffer_meta_header

v1 -> v2:
  * Hide data_pages from the userspace struct
  * Fix META_PAGE_MAX_PAGES
  * Support for order > 0 meta-page
  * Add missing page->mapping.

Vincent Donnefort (2):
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Allow user-space mapping of the ring-buffer

 include/linux/ring_buffer.h     |   7 +
 include/uapi/linux/trace_mmap.h |  31 +++
 kernel/trace/ring_buffer.c      | 326 +++++++++++++++++++++++++++++++-
 kernel/trace/trace.c            |  82 +++++++-
 4 files changed, 440 insertions(+), 6 deletions(-)
 create mode 100644 include/uapi/linux/trace_mmap.h


base-commit: 626c67169f9972fffcdf3bc3864de421f162ebf5
-- 
2.41.0.585.gd2178a4bd4-goog

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <signal.h>
#include <errno.h>
#include <unistd.h>
#include <tracefs.h>
#include <kbuffer.h>
#include <event-parse.h>
#include <poll.h>

#include <asm/types.h>
#include <sys/mman.h>
#include <sys/ioctl.h>

#define TRACE_MMAP_IOCTL_GET_READER_PAGE	_IO('T', 0x1)

/* Need to access private struct to save counters */
struct kbuffer {
	unsigned long long      timestamp;
	long long               lost_events;
	unsigned long           flags;
	void                    *subbuffer;
	void                    *data;
	unsigned int            index;
	unsigned int            curr;
	unsigned int            next;
	unsigned int            size;
	unsigned int            start;
	unsigned int            first;

	unsigned int (*read_4)(void *ptr);
	unsigned long long (*read_8)(void *ptr);
	unsigned long long (*read_long)(struct kbuffer *kbuf, void *ptr);
	int (*next_event)(struct kbuffer *kbuf);
};

struct trace_buffer_read_page {
	unsigned long	lost_events;	/* Events lost at the time of the reader swap */
	__u32	id;			/* Reader page ID from 0 to nr_data_pages - 1 */
	__u32	read;			/* Number of bytes read on the reader page */
};

struct trace_buffer_meta {
	unsigned long	entries;
	unsigned long	overrun;
	unsigned long	read;

	unsigned long	pages_touched;
	unsigned long	pages_lost;
	unsigned long	pages_read;

	struct trace_buffer_read_page reader_page;

	__u32		meta_page_size;		/* Size of the meta-page */
	__u32		meta_struct_len;	/* Len of this struct */
	__u32		nr_data_pages;		/* Number of pages in the ring-buffer */
};

static char *argv0;
static bool exit_requested;

static char *get_this_name(void)
{
	static char *this_name;
	char *arg;
	char *p;

	if (this_name)
		return this_name;

	arg = argv0;
	p = arg+strlen(arg);

	while (p >= arg && *p != '/')
		p--;
	p++;

	this_name = p;
	return p;
}

static void __vdie(const char *fmt, va_list ap, int err)
{
	int ret = errno;
	char *p = get_this_name();

	if (err && errno)
		perror(p);
	else
		ret = -1;

	fprintf(stderr, "  ");
	vfprintf(stderr, fmt, ap);

	fprintf(stderr, "\n");
	exit(ret);
}

void pdie(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	__vdie(fmt, ap, 1);
	va_end(ap);
}

#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))

static unsigned long number_entries(struct trace_buffer_meta *meta)
{
	return READ_ONCE(meta->entries) - (READ_ONCE(meta->overrun) +
					   READ_ONCE(meta->read));
}

static void read_page(struct tep_handle *tep, struct kbuffer *kbuf)
{
	static struct trace_seq seq;
	struct tep_record record;

	if (seq.buffer)
		trace_seq_reset(&seq);
	else
		trace_seq_init(&seq);

	while ((record.data = kbuffer_read_event(kbuf, &record.ts))) {
		kbuffer_next_event(kbuf, NULL);
		tep_print_event(tep, &seq, &record,
				"%s-%d %9d\t%s\n", TEP_PRINT_COMM,
				TEP_PRINT_PID, TEP_PRINT_TIME, TEP_PRINT_NAME);
		trace_seq_do_printf(&seq);
		trace_seq_reset(&seq);
	}
}

static int next_reader_page(int fd, struct trace_buffer_meta *meta, unsigned long *read)
{
	__u32 prev_read, prev_reader, new_reader;

	prev_read = READ_ONCE(meta->reader_page.read);
	prev_reader = READ_ONCE(meta->reader_page.id);
	if (ioctl(fd, TRACE_MMAP_IOCTL_GET_READER_PAGE) < 0)
		pdie("ioctl");
	new_reader = READ_ONCE(meta->reader_page.id);

	if (prev_reader != new_reader)
		*read = 0;
	else
		*read = prev_read;

	return new_reader;
}

static void signal_handler(int unused)
{
	printf("Exit!\n");
	exit_requested = true;
}

int main(int argc, char **argv)
{
	int page_size, meta_len, data_len, page, fd;
	struct trace_buffer_meta *map;
	struct tep_handle *tep;
	struct kbuffer *kbuf;
	unsigned long read;
	void *meta, *data;
	char path[32];
	int cpu;

	if (argc != 2)
		return -EINVAL;

	argv0 = argv[0];
	cpu = atoi(argv[1]);
	snprintf(path, 32, "per_cpu/cpu%d/trace_pipe_raw", cpu);

	tep = tracefs_local_events(NULL);
	kbuf = tep_kbuffer(tep);
	page_size = getpagesize();

	fd = tracefs_instance_file_open(NULL, path, O_RDONLY);
	if (fd < 0)
		pdie("raw");

	meta = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
	if (meta == MAP_FAILED)
		pdie("mmap");
	map = (struct trace_buffer_meta *)meta;
	meta_len = map->meta_page_size;

	printf("entries:	%lu\n", map->entries);
	printf("overrun:	%lu\n", map->overrun);
	printf("read:		%lu\n", map->read);
	printf("pages_touched:	%lu\n", map->pages_touched);
	printf("pages_lost:	%lu\n", map->pages_lost);
	printf("pages_read:	%lu\n", map->pages_read);

	data_len = page_size * map->nr_data_pages;
	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED, fd, meta_len);
	if (data == MAP_FAILED)
		pdie("mmap data");

	signal(SIGINT, signal_handler);

	while (!exit_requested) {
		page = next_reader_page(fd, map, &read);
		kbuffer_load_subbuffer(kbuf, data + page_size * page);
		while (kbuf->curr < read)
			kbuffer_next_event(kbuf, NULL);

		read_page(tep, kbuf);
	}

	munmap(data, data_len);
	munmap(meta, page_size);
	close(fd);

	return 0;
}
