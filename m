Return-Path: <linux-kernel+bounces-88997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D1686E93D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF0C1F22812
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB6839FCF;
	Fri,  1 Mar 2024 19:11:32 +0000 (UTC)
Received: from relay163.nicmail.ru (relay163.nicmail.ru [91.189.117.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A7E38DCD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320291; cv=none; b=AKqvCf7qNUnP0+zlLJMbuRtIbvsc8VlxbyFPIgaF3c8H9q+BmMWSYwRtwqw9AknTq6gkgZYLHqc1N886cMWm9t9LeIrWBHRgzXrAI8+Q7n8iWgnzgleUO19nDbo96k0zzTN8s5PwrLJkkhwR1mhRvkwB9JbxB2fCG2WqccJ/CXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320291; c=relaxed/simple;
	bh=3Nq+k+n8G/JV8Nia6Movo1ADaLHtyQXbtdFxIzcy60s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xwf5f423K4R/HrMmFJzKuLLMP085sjuR1/5BXL7/30OcmRJq6qpysb5BYFrhpwA9I8riaZi5B8PePk1W59Qv/Z3pzxbXnVrc4HM2wgAFf0X5U8vMrQkCG6IyrctcHZBZZnyo+Zy6AeIwXZD2S9Z4R7WZLag1N0QKFwl2dNobLaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.152] (port=9840 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rg83n-0005PA-BC;
	Fri, 01 Mar 2024 21:56:43 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1104.mail.hosting.nic.ru (Exim 5.55)
	with id 1rg83n-00A9hx-1J;
	Fri, 01 Mar 2024 21:56:43 +0300
Message-ID: <ecfb0f31-a454-4a51-9fb8-9cd0aca3195c@ancud.ru>
Date: Fri, 1 Mar 2024 21:56:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikita Kiryushin <kiryushin@ancud.ru>
Subject: Re: [PATCH] drm/i915: Remove unneeded double drm_rect_visible call in
 check_overlay_dst
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Manasi Navare <manasi.d.navare@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <> <79c92cfa-cf5a-4a23-8a93-11c1af7432fc@ancud.ru>
 <ZeB45WKv4lP8QQpv@intel.com>
Content-Language: en-US
In-Reply-To: <ZeB45WKv4lP8QQpv@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-SCL: -1

On 2/29/24 15:30, Ville Syrjälä wrote:
> I prefer the current way where we have no side effects in
> the if statement.
>

This seem like a valid concern from readability and maintainability 
standpoint. My patch was aimed mostly at performance and maintainability 
using tools: some more pedantic analyzers are sensitive to non-checked 
return values (as of now, drm_rect_intersect is ignored).

Would it be a better idea to make an update to the patch with second 
drm_rect_visible call changed to an appropriately named state flag set 
with drm_rect_intersect result?

BTW, the original patch somehow got mangled while it made its way to the 
patchwork: source list line in patch got broken, which permits the patch 
from being applied (the original version did not have that line break). 
Any ideas how to prevent this happening with the second version of patch 
(in case the idea is viable)?

