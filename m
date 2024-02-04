Return-Path: <linux-kernel+bounces-51705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C60B848E65
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EE01F226FD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCC5225D7;
	Sun,  4 Feb 2024 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kvfou9IU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310E522F03;
	Sun,  4 Feb 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056737; cv=none; b=KrvZsLoItadyAy96LynSDCok+YJttyKV94wzQuGelLKqy++qfLZSFCv4vG6llYmC3jgfq0csbL71ej50xnEjAj3ii3S2fYNmVbGeG6uzym7lkGtPVhQjc1g4AlX3SReRrh2eWiiLOOtfRKZ4HTueHj+XC69xM43zY3Wg9PLF8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056737; c=relaxed/simple;
	bh=tzIIx1NlqpaSYKxtHJxg/xYuYYs8oFTP8cl3GJ0R6Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iw+PpmXmuLNNAywdVVExgn0D/mFpbRzyOkA1NkQc/w5ThGQyfnLkQmK0Ry4Alk3LrjL+JhBZhbljLXBJJA8bbnxELaOa3d9qZ+Shw8GTn1jTbzC314yzi9jrRRL5O+mty8shhYrtU/chwVrNL/HaOcn0g/0l0XuFoqwc2lvRvvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kvfou9IU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F8FC433F1;
	Sun,  4 Feb 2024 14:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707056736;
	bh=tzIIx1NlqpaSYKxtHJxg/xYuYYs8oFTP8cl3GJ0R6Kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kvfou9IUCWbytQE+DIm1p1q4jaZgGDhX2rbyPJbpTzF8eIg3E5B6fmZfcuQJygDP8
	 Thzl46l2ERX/ii57rADRBaDqF4F27F5jfD5Of0yJ+3jc7KWyhlnQBzQMWJ7Suxsm8N
	 Ycp/U0FgoWBb3KIybNeLEARc3H/5nmEpCOGf9ZLk=
Date: Sun, 4 Feb 2024 06:25:34 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: make pmu_bus const
Message-ID: <2024020420-cupbearer-cape-9543@gregkh>
References: <20240204-bus_cleanup-events-v1-1-c779d1639c3a@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-events-v1-1-c779d1639c3a@marliere.net>

On Sun, Feb 04, 2024 at 10:29:39AM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the pmu_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

