Return-Path: <linux-kernel+bounces-77290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E38860348
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2137281FED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A79F6AFAA;
	Thu, 22 Feb 2024 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d01xQM2W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639836AF8A;
	Thu, 22 Feb 2024 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631693; cv=none; b=CiwyNpVuCRhRudB7sRpxbVJ7df6Juz7CUDDABUO2jqTJSQVIhvyiZERBq/kSz6lOpLFwIWgnU0mg7GW4JSCVuYkZPk/z5Ez7kAS8DXNHKjbYjY+G5lSHFerDuTPacsK1zU3vYK+nEBqDEKQZ3GMUuI/l7B50rTsUVWXGyEVTQnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631693; c=relaxed/simple;
	bh=bSjeGRhKKcsTliuguvmBrYAYCXALQGnt4jTIGPUKbxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+wQpKSs+ZkmfOxQbONs3A3gxOr+90b+11iYXxgmMjV3d6ckfL4t2kslZzX+nvXyHjqD9EWTYClFr3KqPduGtaTcxxeM1RrGH3w/pD78ym/oG39meniI+boHoGn+7ReCFanUlxQ62rmhOxkzZKvLG0eW95MNjS8TH0qxMObllDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d01xQM2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FEFC433F1;
	Thu, 22 Feb 2024 19:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708631692;
	bh=bSjeGRhKKcsTliuguvmBrYAYCXALQGnt4jTIGPUKbxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d01xQM2WWi8U9v1enS4CDg7faOEehZVjZL+xrVT3C73d0cyZMAy0kMaClxhHeD1Eg
	 RUAcBZdhrOz1FprZsrSo/rdCS5FRFCiLHgp3xLfSzlexVbLyIibEZR2zrAcONB9Yoj
	 4Xdm77/5d43k/FgM4YoDgGvlzsEBtO/rzV+t5P2zxbvQyISASUOhcSFsp/jaqEMhHD
	 DJodJH7ZlpB/LJZEVpny04B439ZJl79A19pdu2dK+eUJnZ45YJEpr1fIBL0+LrS0nT
	 FBctZo46GCxwciW7vkKhDeKILNovNB3gd9rCCesYVbT1+arnSr8qUjSlDyHOYtGlzo
	 pfrhZdfpn8jKQ==
Date: Thu, 22 Feb 2024 16:54:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kyle Huey <me@kylehuey.com>
Cc: Ian Rogers <irogers@google.com>, Kyle Huey <khuey@kylehuey.com>,
	Robert O'Callahan <robert@ocallahan.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf test: Test FASYNC with watermark wakeups.
Message-ID: <ZdemibZepMqWvv6U@x1>
References: <20240221175210.19936-1-khuey@kylehuey.com>
 <20240221175210.19936-2-khuey@kylehuey.com>
 <CAP-5=fXsv7TJ_SVOZc38fN0gn+7cWBcMWt3FdVLcs5v0_vO=uw@mail.gmail.com>
 <CAP045AoSHWoOP3TN=6Hf2wZj7X9Y41sThBQWCDZ3BEP68qeTBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP045AoSHWoOP3TN=6Hf2wZj7X9Y41sThBQWCDZ3BEP68qeTBw@mail.gmail.com>

On Thu, Feb 22, 2024 at 09:55:36AM -0800, Kyle Huey wrote:
> On Wed, Feb 21, 2024 at 10:36 AM Ian Rogers <irogers@google.com> wrote:
> > On Wed, Feb 21, 2024 at 9:52 AM Kyle Huey <me@kylehuey.com> wrote:
> > > +       if (fcntl(fd, F_SETFL, FASYNC)) {
> > > +               pr_debug("failed F_SETFL FASYNC %d\n", errno);
> > > +               goto cleanup;
> > > +       }

> > Thanks for the work! The perf tool and perf test should run on older
> > kernels ideally without failure. I'm assuming this would fail on an
> > older kernel. Could we make the return value skip in that case?
 
> Ah, hmm, I wasn't aware of that. This would fail on an older kernel,
> yes. It's not possible to distinguish between an older kernel and a
> kernel where this fix broke (at least not without hardcoding in an
> expected good kernel version, which seems undesirable), so that would

Take a look at:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/tools/perf/tests/sigtrap.c?id=650e0bde43f35bb675e87e30f679a57cfa22e0e5

To see how introspecting using BTF can be used to figure out if internal
data structures have what is needed, or if functions with some specific
arguments are present, etc, for sigtrap we have, in the patch above:

-       TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_count, NUM_THREADS * ctx.iterate_on);
+       expected_sigtraps = NUM_THREADS * ctx.iterate_on;
+
+       if (ctx.signal_count < expected_sigtraps && kernel_with_sleepable_spinlocks()) {
+               pr_debug("Expected %d sigtraps, got %d, running on a kernel with sleepable spinlocks.\n",
+                        expected_sigtraps, ctx.signal_count);
+               pr_debug("See https://lore.kernel.org/all/e368f2c848d77fbc8d259f44e2055fe469c219cf.camel@gmx.de/\n");
+               return TEST_SKIP;
+       } else
+               TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_count, expected_sigtraps);

And then:

+static bool kernel_with_sleepable_spinlocks(void)
+{
+       const struct btf_member *member;
+       const struct btf_type *type;
+       const char *type_name;
+       int id;
+
+       if (!btf__available())
+               return false;
+
+       id = btf__find_by_name_kind(btf, "spinlock", BTF_KIND_STRUCT);
+       if (id < 0)
+               return false;
+
+       // Only RT has a "lock" member for "struct spinlock"
+       member = __btf_type__find_member_by_name(id, "lock");
+       if (member == NULL)
+               return false;
+
+       // But check its type as well
+       type = btf__type_by_id(btf, member->type);
+       if (!type || !btf_is_struct(type))
+               return false;
+
+       type_name = btf__name_by_offset(btf, type->name_off);
+       return type_name && !strcmp(type_name, "rt_mutex_base");
+}

> mean the test would always return ok or skip, not ok or fail. Is that
> ok?

It should return:

Ok if the kernel has what is needed and the test passes
Skip if the test fails and the kernel doesn't have what is needed
FAIL if the test fails and the kernel HAS what is needed.

'perf test sigtrap' also checks for the presence of the feature it
requires:

static bool attr_has_sigtrap(void)
{
        int id;

        if (!btf__available()) {
                /* should be an old kernel */
                return false;
        }

        id = btf__find_by_name_kind(btf, "perf_event_attr", BTF_KIND_STRUCT);
        if (id < 0)
                return false;

        return __btf_type__find_member_by_name(id, "sigtrap") != NULL;
}

        fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
        if (fd < 0) {
                if (attr_has_sigtrap()) {
                        pr_debug("FAILED sys_perf_event_open(): %s\n",
                                 str_error_r(errno, sbuf, sizeof(sbuf)));
                } else {
                        pr_debug("perf_event_attr doesn't have sigtrap\n");
                        ret = TEST_SKIP;
                }
                goto out_restore_sigaction;
        }

- Arnaldo

