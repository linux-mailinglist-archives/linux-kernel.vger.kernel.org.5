Return-Path: <linux-kernel+bounces-139320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873738A015E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1873A1F27687
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFD7181CE0;
	Wed, 10 Apr 2024 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFEHYAiR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA81181B9F;
	Wed, 10 Apr 2024 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712781517; cv=none; b=Ov9c8N6634UDRNcD0PfVGrsaYEHldu+BAM0hlexjtlxud0nKuAkndXQ0dyiUJeysVyfLHBSiWsmF+a3xpdn/nOIbRH/o1E7OZ7QYGCl8k3hK8tBDOfvFK47ogJ96ycz1FD3T+hzVYSAhaMQOsO4jg2N5ij/vfDJYVTwSszdpIkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712781517; c=relaxed/simple;
	bh=/HoZeNzG6zaY4GRuRf8eyKh33b0YMjx8EBiXsVQb2Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAkCWqCPBGC9zRZS6ukt082LgtgXBn3oJ9bYP2rgevvcvBOWpuF9qD7fSBMcGrXLgzrypbzaxenfFxTpxz2dW4EDamauyOwyHyYyo5s3Lb8fVkiTZQIVxOvw9/DUAWWsIMV+ZKLxsMsc4Zko2EFeiFqGHtOahiAfbD0Je2t+5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFEHYAiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04E2C433F1;
	Wed, 10 Apr 2024 20:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712781517;
	bh=/HoZeNzG6zaY4GRuRf8eyKh33b0YMjx8EBiXsVQb2Ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jFEHYAiR7BEFnaBCKdWLiS42v69jjRafCf6tx3a8bBjZf9s4IWk10Cmj/wJS4IFR3
	 h9zbEg7hs5fQoUhLeD6M15JGjaPeNHpCUoIcs7pjnBf1vdFoDoTqPq5VA99MzoSfwh
	 air4ngKXWkx9bBjQDI2mgmCl6waaBGFeDqZI0ilk/aY4E+zOsD/TgcTl69WOeLjQIi
	 hy4BS4UxshMznv/u+uwGW0KS9KCR/UKE0JH6OvcJ5lVeUTkYJTQZiEcBiXC7fd9sgA
	 71zyD8I724rCL7bQGTz2081Hqwjxqw1nispkX+/GmqWYHYWQkE/kl1GNWg/ytc7wUA
	 AKR87nXFKHxQg==
Date: Wed, 10 Apr 2024 17:38:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/6] perf annotate-data: Support event group display in
 TUI
Message-ID: <Zhb4yUkLbpnZZil-@x1>
References: <20240409235000.1893969-1-namhyung@kernel.org>
 <20240409235000.1893969-5-namhyung@kernel.org>
 <Zhb1lZYuk1cfiFOD@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhb1lZYuk1cfiFOD@x1>

On Wed, Apr 10, 2024 at 05:24:56PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 09, 2024 at 04:49:58PM -0700, Namhyung Kim wrote:
> > Like in stdio, it should print all events in a group together.
> 
> How to test this?
> 
> You mean something like:
> 
> root@number:~# perf record -a -e '{cpu_core/mem-loads,ldlat=30/P,cpu_core/mem-stores/P}'
> ^C[ perf record: Woken up 8 times to write data ]
> [ perf record: Captured and wrote 4.980 MB perf.data (55825 samples) ]
> 
> root@number:~#
> 
> root@number:~# perf annotate --stdio --data-type
> 
> And then having the same output in the TUI?
> 
> Trying this...

Added, the following, ok?

And the --stdio has all the missing info in TUI:

  Annotate type: 'union ' in /usr/lib64/libc.so.6 (1131 samples):
   event[0] = cpu_core/mem-loads,ldlat=30/P
   event[1] = cpu_core/mem-stores/P

Committer notes:

Collect it:

  root@number:~# perf record -a -e '{cpu_core/mem-loads,ldlat=30/P,cpu_core/mem-stores/P}'
  ^C[ perf record: Woken up 8 times to write data ]
  [ perf record: Captured and wrote 4.980 MB perf.data (55825 samples) ]
  root@number:~#

Then do it in stdio:

  root@number:~# perf annotate --stdio --data-type

  Annotate type: 'union ' in /usr/lib64/libc.so.6 (1131 samples):
   event[0] = cpu_core/mem-loads,ldlat=30/P
   event[1] = cpu_core/mem-stores/P
  ============================================================================
           Percent     offset       size  field
    100.00  100.00          0         40  union    {
    100.00  100.00          0         40      struct __pthread_mutex_s    __data {
     48.61   23.46          0          4          int     __lock;
      0.00    0.48          4          4          unsigned int    __count;
      6.38   41.32          8          4          int     __owner;
      8.74   34.02         12          4          unsigned int    __nusers;
     35.66    0.26         16          4          int     __kind;
      0.61    0.45         20          2          short int       __spins;
      0.00    0.00         22          2          short int       __elision;
      0.00    0.00         24         16          __pthread_list_t        __list {
      0.00    0.00         24          8              struct __pthread_internal_list*     __prev;
      0.00    0.00         32          8              struct __pthread_internal_list*     __next;
                                                  };
                                              };
      0.00    0.00          0          0      char*       __size;
     48.61   23.94          0          8      long int    __align;
                                          };

Now with TUI before this patch:

  root@number:~# perf annotate --tui --data-type
  Annotate type: 'union ' (790 samples)
      Percent     Offset       Size  Field
       100.00          0         40  union  {
       100.00          0         40      struct __pthread_mutex_s __data {
        48.61          0          4          int  __lock;
         0.00          4          4          unsigned int __count;
         6.38          8          4          int  __owner;
         8.74         12          4          unsigned int __nusers;
        35.66         16          4          int  __kind;
         0.61         20          2          short int    __spins;
         0.00         22          2          short int    __elision;
         0.00         24         16          __pthread_list_t     __list {
         0.00         24          8              struct __pthread_internal_list*  __prev;
         0.00         32          8              struct __pthread_internal_list*  __next;


         0.00          0          0      char*    __size;
        48.61          0          8      long int __align;
                                     };

And now after this patch:

Annotate type: 'union ' (790 samples)
               Percent     Offset       Size  Field
     100.00     100.00          0         40  union  {
     100.00     100.00          0         40      struct __pthread_mutex_s      __data {
      48.61      23.46          0          4          int       __lock;
       0.00       0.48          4          4          unsigned int      __count;
       6.38      41.32          8          4          int       __owner;
       8.74      34.02         12          4          unsigned int      __nusers;
      35.66       0.26         16          4          int       __kind;
       0.61       0.45         20          2          short int __spins;
       0.00       0.00         22          2          short int __elision;
       0.00       0.00         24         16          __pthread_list_t  __list {
       0.00       0.00         24          8              struct __pthread_internal_list*       __prev;
       0.00       0.00         32          8              struct __pthread_internal_list*       __next;
                                                      };
                                                  };
       0.00       0.00          0          0      char* __size;
      48.61      23.94          0          8      long int      __align;
                                              };

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>


