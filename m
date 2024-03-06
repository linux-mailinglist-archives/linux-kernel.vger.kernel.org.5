Return-Path: <linux-kernel+bounces-94033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CF28738DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29871C21057
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA77132492;
	Wed,  6 Mar 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="X0P9x3OT"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149AA13174A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734945; cv=none; b=dH6tdHjWA0KpWkK0aF3ej44xjNl3IVZ5qcyaYogg3fvfKawzPntqfcC8f5Aok1cMVGF27JoQp5tHmhW31fAe1v49C9CCbfcsXJ/pq6ZW4udbrWQfNBmPO0XDlyHHmVv/pxrgPCcytpEJG5+C7JgG2cHrU9MuQAZW1LQxdidOowE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734945; c=relaxed/simple;
	bh=qxYOwaZcbx8hyWY5Ie0DRgeqhjQYZZ3KBdeahsa+ULc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjtrUKrO8/CcuiBf/oCuZDJgi1ZnFIbJbt6tQ6+CdTZsc76Bu8pQT8tzzN1yKaq8b5VWvgXNSbHEhkV7LQMhnnskt4WAWchH4RXUSUsADwbYS8Ul/2dwF1pGPHGSIxvkreii03d7JAofr9MWdbhjsQoInEE0fiiN0MPICfehY8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io; spf=pass smtp.mailfrom=foundries.io; dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b=X0P9x3OT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundries.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412eeb018ffso13919945e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 06:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1709734942; x=1710339742; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cOt02qNbcMDdF+TSWPrUZScoOyboAJRj4lBIhLrn6nI=;
        b=X0P9x3OTiV2FkrXiaKle/QAXw6QfrgTqjpXyWG6q8guu/IhQrbFNoOXNEtNmlE70oR
         rtLrue7xz9G/U+cMLhYW65QufJD8TrXVT2HPognKKwB7j2xMfsLnyZExr67CugrGJEdT
         uQ7q2yLXm/xfVJticlxLVVL4bs1c1jib2Q+2bMqCY5MlTxhPQzfl+YdKGM7o8P7+957/
         nebrV8XCtwJWCQxf9WvCFVSZQM1SbvD6Mu+5QidgqFV7hEjZZIgzqq7dzt0hApd4MjOY
         g/1QdncTQoVvtArqZ7XKSFnf1a9VBnmTmoyLzICAgJNAL9eloWn9J9b7oNgQasfMKDDF
         MNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709734942; x=1710339742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOt02qNbcMDdF+TSWPrUZScoOyboAJRj4lBIhLrn6nI=;
        b=g32OQFuI/LhifmQtsKawjeldy9veynBN2q6jEv19tcQxKeDdtS1m2fzK0CqHunlYI3
         oUGTUnHvZNIPpkscmw5RcKgtgLjkpMulCGfw/qnJ04S/5wNDEnqDaU4z8xLYM3WJoK1y
         DQap1btvnfF/ZX/jWOj4ZtYhG5oUqex8/QTF1WstlZ6rF1SUn36SDVJb1V0UZ85C+RVv
         junAQh0XPx0a2FLeRrNJ6CFaUsOrkrouS4T1ZWZesVop7SVP6ezrUmAUiUdqyNFb/HCL
         GFCmbta2CjVnBVCBEMP0fcuGHHBueP6eWDMchnDm8ZGnYUe0/b80baUaSt4VRTVlf0BK
         mlZA==
X-Forwarded-Encrypted: i=1; AJvYcCUzUJ9m4ScxiYsB7Jn9laloAxO4LXfhpwQXDX7ZI6Nqrn4BtXSTK7wooB8o7uXXHyBSbXuXr+UuM7LrIBej0yQjVHJwqeI5SS9Xqjan
X-Gm-Message-State: AOJu0YwVfzKfnzJOmluitKdNruzlrvPi0G5BFK4QPVoDIdGvG/i+Kczb
	zEK+26CyfQ0O01EmdcUSrpBJJEs1DfLxMgblaX3dfzXDPtdWXhArNYJNiCjLczw=
X-Google-Smtp-Source: AGHT+IG+O14wyWHMVOWekCfQvwWKXcXAS82ZA8/4Fv/QDUBev5zw4Lh2wL576FZOCtNprYufeVeXMQ==
X-Received: by 2002:adf:b199:0:b0:33d:873a:616 with SMTP id q25-20020adfb199000000b0033d873a0616mr10057350wra.64.1709734942333;
        Wed, 06 Mar 2024 06:22:22 -0800 (PST)
Received: from trax (132.red-81-38-137.dynamicip.rima-tde.net. [81.38.137.132])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d4a06000000b0033dbeb2eb4dsm17642666wrq.110.2024.03.06.06.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:22:21 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Wed, 6 Mar 2024 15:22:20 +0100
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
Message-ID: <Zeh8HGDToMoHglD2@trax>
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>
 <Zegx5PCtg6hs8zyp@trax>
 <CACRpkdYZrDgVVCp2bqJqY1BpeHSXDWbRSqk6d=N_QhC4OVv=Ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYZrDgVVCp2bqJqY1BpeHSXDWbRSqk6d=N_QhC4OVv=Ew@mail.gmail.com>

On 06/03/24 14:18:49, Linus Walleij wrote:
> On Wed, Mar 6, 2024 at 10:05 AM Jorge Ramirez-Ortiz, Foundries
> <jorge@foundries.io> wrote:
>
> > That looked strange as there should be support for 4 GP but this code
> > kind of convinced me of the opposite.
> >
> >         if (idata->rpmb) {
> >                 /* Support multiple RPMB partitions */
> >                 target_part = idata->rpmb->part_index;
> >                 target_part |= EXT_CSD_PART_CONFIG_ACC_RPMB;
> >         }
> >
> > So if we apply the fix that you propose, how are multiple RPMB
> > partitions (ie, 4) going to be identified as RPMB? Unless there can't be
> > more than 3?
>
> As far as I can tell there can only be one RPMB partition per device.

that matches everything I have seen in the field too (and we have been
supporting RPMB on many designs lately (# > 30).

>
> The v5.1A spec says (section 6.2.1):
>
> "Two Boot Area Partitions, (...)"
> "One RPMB Partition accessed through a trusted mechanism, (...)"
> "Four General Purpose Area Partitions (...)"
>
> implying there can be only one RPMB.
>
> Also I have never seen more than one in practice.

+1

so I think it is safe to conclude that my commit did indeed cause these
regressions as it ignored the support for multiple GP. Sorry about it!.

I still cant grasp how "target_part = idata->rpmb->part_index" is
helping in the design.

What happens when:
1) EXT_CSD_PART_CONFIG_ACC_MASK > part_index > EXT_CSD_PART_CONFIG_ACC_RPMB
target_part now could be indicating a GP instead of an RPMB leading to failures.

2) part_index <= EXT_CSD_PART_CONFIG_ACC_RPMB
loses the part_index value .

So part_index should be larger than EXT_CSD_PART_CONFIG_ACC_MASK even
though the comment indicates it starts at 0?

/**
 * struct mmc_rpmb_data - special RPMB device type for these areas
 * @dev: the device for the RPMB area
 * @chrdev: character device for the RPMB area
 * @id: unique device ID number
 * @part_index: partition index (0 on first)    <---------------------
 * @md: parent MMC block device
 * @node: list item, so we can put this device on a list
 */
struct mmc_rpmb_data {
	struct device dev;
	struct cdev chrdev;
	int id;

is it just possible that "target_part = idata->rpmb->part_index" just
needs to be shifted to avoid issues?

I think the fix to the regression I introduced could perhaps address
this as well.

