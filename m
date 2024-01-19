Return-Path: <linux-kernel+bounces-31372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5724832D60
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B271C219B7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC62354FB0;
	Fri, 19 Jan 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="X/jyD+VG"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D741F170
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682504; cv=none; b=NxDvXjHiuqoF4I9oIN7N6Iw0WlB0wknwmwqsTIXTCna5snllxJbYlZi6MJ3Yc9EuCumZSmOusZIn/QSnFzIDJshRoPUmRcKhKn6SXY/CSMoF7wdookqrWrkhwwTIeNU4sgtbz+TIBDgu/0gfvk7X2vZ6IcK9GnxoN8IefD+dDRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682504; c=relaxed/simple;
	bh=azMRYqvk1Vz+HvUwch48zgp9sztbupEWVObn4s0Ufrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OvO7yjh+hjOmEPGPME25AAA+vVfuzAg6X0NL8Rvmcpde8Eu8A4/tXYY0TXNoB/vyP8IBpRIePTPBJtf1j7W3M5zhjp4jz7qvQgPjj8GHo1u/zDsAYKo/FJbUwb98yI/6yUEENxMSvTzRP/V3TSlpV6hEDUGM777Kt9tPnlC3FUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=X/jyD+VG; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso9700139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705682501; x=1706287301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sQklyqCzykir7KyEueElXoaEtB+kuoHpU7ZGJJMiaxM=;
        b=X/jyD+VGS71qIv4BgELKZBYQQ+4hnEHd+Dw8FYaBujRdjxxqsh3rPC/b0da7prMmSC
         P8Cv6C0N6DyxCJcQ5WtD5Gnx226SILBaepvlqK0Gb8bm+hfdY5BoxRwU4Wb7m8fQbz/3
         RqOjc1GwGx20G/+9XiystXGFUnmEAK9ZB2Yxlp061UCT8OEiDgi4rDszpWmfNKHsvWCq
         CnprH6KaNOxvU60751CdRF0AaiIyvZY15oNiRCT7SIgUSzZQP3W3Czu9IuyW5zF00/aC
         UMGawu75NKP47ijwUX6qz12Z8XkJdzJ/7pLqsntUNSORcrv+7cTVvITcl7mSrdG1x2fJ
         R65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705682501; x=1706287301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sQklyqCzykir7KyEueElXoaEtB+kuoHpU7ZGJJMiaxM=;
        b=OjM8OMH32PYpSH34C5lcca/yw7J2gZE6fzDuGvtwwrZNUG71ZnX8f8cr2I1N6GVqy3
         FLAIL+WluRg9xYEe9bckK/5v4pg2a8i7C0DBlvVk9iwVTeQnvyo+dcTor7qgNTcMgfyc
         tWt0b8fdS4EmZL3CNIVBjZWKHIQpYxaqw2iEst22udZJozhBShKp7u3a++Jt5hNLiyQe
         4hvfwhphWVCxWl1rgpDXRPD0cyOchsJGBQ7HLSxxkQoQsuDvKrARq1mwmlFrczcjeEIL
         lQz9Vwb19CAIqhDsft1sNYdBJ0Fy7WmymJSuN6hKZ/NjdyZ9SSB6Pz/l4itpKR5A+c0L
         H9Rw==
X-Gm-Message-State: AOJu0YyLuyf4MIlp2kzW5PKw7bxBwyyguZLNwirJNyWXnjeOaio5eajC
	2VbUcQz4VabEDrvIOHHMA9qlui5b3Ut09HfAKdMUsLjcVxh1XChMJC6+7hhc48Y=
X-Google-Smtp-Source: AGHT+IEQzErgEl9CkxmRGuWHPrGq7DyyFeysApP9aPzAPnIao1mWImm82UBhKNq81p6iFjY047QXCg==
X-Received: by 2002:a05:6e02:1be8:b0:360:702a:3f89 with SMTP id y8-20020a056e021be800b00360702a3f89mr260523ilv.0.1705682501472;
        Fri, 19 Jan 2024 08:41:41 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bb5-20020a056e02000500b003619ab760f1sm1359094ilb.24.2024.01.19.08.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 08:41:40 -0800 (PST)
Message-ID: <fe1f4fe8-48d8-4b09-bd50-36e8fd8e75cb@kernel.dk>
Date: Fri, 19 Jan 2024 09:41:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Remove unnecessary unlikely()
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240119163434.1357155-1-willy@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240119163434.1357155-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 9:34 AM, Matthew Wilcox (Oracle) wrote:
> Jens added unlikely() thinking that this was an error path.  It's
> actually just the end of the iteration, so does not warrant an
> unlikely().

This is because the previous fix (or my attempt at least) didn't do the
i >= vcnt, it checked for an empty bio instead. Which then definitely
did make it an error/unlikely path, but obviously this one is not.

The bio iterator stuff has gotten terribly unwieldy and complicated, and
not very efficient either. But I guess that's a story for another
investigation...

-- 
Jens Axboe


