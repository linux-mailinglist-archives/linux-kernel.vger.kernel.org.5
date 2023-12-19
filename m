Return-Path: <linux-kernel+bounces-6114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A18194C9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E03B251AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CDD40BE0;
	Tue, 19 Dec 2023 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qG9JfuJL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E494340BE6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=lSzGS7cKGhu4UfvY+zEqdstOj92fkqZRDakmXWHiL4s=; b=qG9JfuJLXvO4mrC6ZGH8PvNo7Z
	1IzTEgAQllZj4UDPtlY9iWTOoNpYG1Yed+Es6w1NRZCZxtHC/OkjoLhV39sLhaqTTSXDA58PioeEE
	34yP+j94+SMk5BzyuHAtaW96NjG338GpD5Hw+aXnhqwv8I8vAYqbQvxqnqGyIY2GcY/WgOtirbM67
	ofYQHaKCbpT72rhT6P29nF3BsvnR9kdinKGB37g+28IAejAFOcQuhDO5Ma0nTHs46rLB+0Vxoh+hN
	AWPQDRq7K6nQgZOxCCEmXgWtA0Z1GYrOJshCdZb7gFNe9y6eXTGfnCgpAnWufZOQvBzJ77fQMt13d
	jhKN5JFA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFjtf-00FiJ6-1H;
	Tue, 19 Dec 2023 23:53:11 +0000
Message-ID: <dc7615d3-f372-4162-b178-4ee2dbfa2a28@infradead.org>
Date: Tue, 19 Dec 2023 15:53:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] mm/ksm: document ksm advisor and its sysfs knobs
Content-Language: en-US
To: Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc: akpm@linux-foundation.org, david@redhat.com, hannes@cmpxchg.org,
 riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231218231054.1625219-1-shr@devkernel.io>
 <20231218231054.1625219-5-shr@devkernel.io>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231218231054.1625219-5-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/18/23 15:10, Stefan Roesch wrote:
> This documents the KSM advisor and its new knobs in /sys/fs/kernel/mm.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  Documentation/admin-guide/mm/ksm.rst | 55 ++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> index e59231ac6bb71..a639cac124777 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -80,6 +80,9 @@ pages_to_scan
>          how many pages to scan before ksmd goes to sleep
>          e.g. ``echo 100 > /sys/kernel/mm/ksm/pages_to_scan``.
>  
> +        The pages_to_scan value cannot be changed if ``advisor_mode`` has
> +        been set to scan-time.
> +
>          Default: 100 (chosen for demonstration purposes)
>  
>  sleep_millisecs
> @@ -164,6 +167,29 @@ smart_scan
>          optimization is enabled.  The ``pages_skipped`` metric shows how
>          effective the setting is.
>  
> +advisor_mode
> +        The ``advisor_mode`` selects the current advisor. Two modes are
> +        supported: none and scan-time. The default is none. By setting
> +        ``advisor_mode`` to scan-time, the scan time advisor is enabled.
> +        The section about ``advisor`` explains in detail how the scan time

                                                                    scan-time

> +        advisor works.
> +
> +adivsor_max_cpu
> +        specifies the upper limit of the cpu percent usage of the ksmd
> +        background thread. The default is 70.
> +
> +advisor_target_scan_time
> +        specifies the target scan time in seconds to scan all the candidate
> +        pages. The default value is 200 seconds.
> +
> +advisor_min_pages_to_scan
> +        specifies the lower limit of the ``pages_to_scan`` parameter of the
> +        scan time advisor. The default is 500.
> +
> +adivsor_max_pages_to_scan
> +        specifies the upper limit of the ``pages_to_scan`` parameter of the
> +        scan time advisor. The default is 30000.

           scan-time

> +
>  The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm/ksm/``:
>  
>  general_profit
> @@ -263,6 +289,35 @@ ksm_swpin_copy
>  	note that KSM page might be copied when swapping in because do_swap_page()
>  	cannot do all the locking needed to reconstitute a cross-anon_vma KSM page.
>  
> +Advisor
> +=======
> +
> +The number of candidate pages for KSM is dynamic. It can be often observed
> +that during the startup of an application more candidate pages need to be
> +processed. Without an advisor the ``pages_to_scan`` parameter needs to be
> +sized for the maximum number of candidate pages. The scan time advisor can
> +changes the ``pages_to_scan`` parameter based on demand.

   change

> +
> +The advisor can be enabled, so KSM can automatically adapt to changes in the
> +number of candidate pages to scan. Two advisors are implemented: none and
> +scan-time. With none, no advisor is enabled. The default is none.
> +
> +The scan time advisor changes the ``pages_to_scan`` parameter based on the

       scan-time

> +observed scan times. The possible values for the ``pages_to_scan`` parameter is
> +limited by the ``advisor_max_cpu`` parameter. In addition there is also the
> +``advisor_target_scan_time`` parameter. This parameter sets the target time to
> +scan all the KSM candidate pages. The parameter ``advisor_target_scan_time``
> +decides how aggressive the scan time advisor scans candidate pages. Lower
> +values make the scan time advisor to scan more aggresively. This is the most

I would drop                         to.          aggressively

> +important parameter for the configuration of the scan time advisor.

                                                    scan-time

> +
> +The initial value and the maximum value can be changed with
> +``advisor_min_pages_to_scan`` and ``advisor_max_pages_to_scan``. The default
> +values are sufficient for most workloads and use cases.
> +
> +The ``pages_to_scan`` parameter is re-calculated after a scan has been completed.

                                      recalculated

> +
> +
>  --
>  Izik Eidus,
>  Hugh Dickins, 17 Nov 2009


thanks.
-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

