Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E74767263
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjG1Qu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjG1QuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:50:13 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB82455A9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:48:46 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-31400956ce8so1195015f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690562888; x=1691167688;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=avARk3fa9ZELyujgb1UvNOZt31pNPsphbQQkoVBUi0A=;
        b=ljjI+drPdZ/Zh/tAMD1D94Nr2P9jFfai5+4hDApoVkuFZP7Ejq1lzBAVqEjOlcdmI2
         gnDnsi1hz/MymJ+L5Wta5hkoe2CQcAeQwFe4PLsW80p116skH8c/59NJ+ltGZ/eLnyNL
         i37gLVrMSxJiYVdxfw2o3eK18qlLJpAazunXjMO+HjnV/6hLhnXJPJ2qDAksBR3WNsoL
         jk3T8HOKzyIB27d6TKL0DPY7tCAXIDz1OZzMM+5UHT9i6+N0IAWe9w4HrXL5uq47P8nQ
         w0NB1ARuLHGDVFaybrUOzZfMqdIRK1/h5h4HsxGvElbAHbnXeQs/eyylolqwmI5Wb4N+
         ypFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562888; x=1691167688;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avARk3fa9ZELyujgb1UvNOZt31pNPsphbQQkoVBUi0A=;
        b=M9gH3gipnCbnfoob3v9kiA44hD2gFZM2mb8p03h3QgFElxTwXt6+uTsJWiewvernLJ
         5QywuAacpIi17knZmasb3sOwE71NmZo0Qx23K9kk5It5NQVzpGBhQ9EOeP3mlmOAl6eh
         x5sWQBlx0UdfDy/bxLlYS2ylCcupjCvaaYh10YG06wILtJDu4HOaKimL5MfXzy0ECR2N
         epppDZ34vqqfRyWL7md93y4YkIO93zlqK8LYuCPqzRAcxAL3XqEkqZv2QSUQXkSVHP5n
         kOvkdwshuUCW+7y7QwIwxv0sztPgSBJM9IO6BVPjcL9FRFh63xTI3mC/Lon0LgXUSYwM
         tiKg==
X-Gm-Message-State: ABy/qLbQD9fHmm0rvSS5CCWEprAe3iww+GFkYkeF/afsU/86MonJYydj
        BzM8tIbm2nxabqE+HNx3GfEgcy+XjrJwZYw6
X-Google-Smtp-Source: APBJJlH40yj7aXbucYrGjegm9OEvlK80UD61iGeHX2l0F19wrcD9QpIEMSkwQg3U1twvlfaHTXJgyokhl2hkV7I/
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a5d:5007:0:b0:317:43de:e206 with SMTP
 id e7-20020a5d5007000000b0031743dee206mr19383wrt.3.1690562888098; Fri, 28 Jul
 2023 09:48:08 -0700 (PDT)
Date:   Fri, 28 Jul 2023 17:47:52 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230728164754.460767-1-vdonnefort@google.com>
Subject: [PATCH v5 0/2] Introducing trace buffer mapping by user-space
From:   Vincent Donnefort <vdonnefort@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 include/uapi/linux/trace_mmap.h |  28 +++
 kernel/trace/ring_buffer.c      | 321 +++++++++++++++++++++++++++++++-
 kernel/trace/trace.c            |  72 ++++++-
 4 files changed, 422 insertions(+), 6 deletions(-)
 create mode 100644 include/uapi/linux/trace_mmap.h

-- 
2.41.0.487.g6d72f3e995-goog

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

struct ring_buffer_meta {
        unsigned long   entries;
        unsigned long   overrun;
        unsigned long   read;

        unsigned long   pages_touched;
        unsigned long   pages_lost;
        unsigned long   pages_read;

        __u32           meta_page_size;
        __u32           nr_data_pages;  /* Number of pages in the ring-buffer */

        struct reader_page {
                __u32   id;             /* Reader page ID from 0 to nr_data_pages - 1 */
                __u32   read;           /* Number of bytes read on the reader page */
                unsigned long   lost_events; /* Events lost at the time of the reader swap */
        } reader_page;
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

static unsigned long number_entries(struct ring_buffer_meta *meta)
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

static int next_reader_page(int fd, struct ring_buffer_meta *meta, unsigned long *read)
{
	__u32 prev_reader, new_reader;
	unsigned long prev_read;

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
	struct ring_buffer_meta *map;
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
	map = (struct ring_buffer_meta *)meta;
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
		if (!number_entries(map)) {
			usleep(100000);
			continue;
		}

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
