Return-Path: <linux-kernel+bounces-84003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E4C86A13A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A701C23D88
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1989B14EFDD;
	Tue, 27 Feb 2024 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QtVGwrYH"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5193214DFFA
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067327; cv=none; b=FcwZVL5b687VFuzEnWJpwTj3rrYmGle+1rKBiL6jmn+OIo94OR34XSUUTjyVT3+UcaMSduThNqyX0+zP6C3+RMWtTVVtrDGfHqWvejfgZ1LJo85ZPo8dp7d8rdiynT3EsI/L01KI7tkG0CUDe9Gl0TocXxuNPrdtlB0mNRJ0YRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067327; c=relaxed/simple;
	bh=cn6YOKUX5dA3ag8i1Tc2HjJMtQinFT7ylVNBEPwuuIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6eM2iNmVt6ultAKecYuCeLMDILtsPlzNAhkhDJ151tx2OUTYUDVOmw3AKEjCzD0ptabBwp4jG4LdhnZ3xydgbMewpPLW1E858hY7n8IT0Eqz6FW5OhoR/n1zn4HgUIIPfVqqZmfAQC+L2xs08qFnqY1Kw2ZmIAfd6ZuXeeioz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QtVGwrYH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3f4464c48dso576805966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709067323; x=1709672123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UKCWCT93031ctnu4e0l2nLLoQn5zgMFTn2j+yBK/CsE=;
        b=QtVGwrYHR6ZoSVBDdHphTeDow/uQR0Sh+WtDzvuOtOmiGwye3DA9FZ0VmHakoDckVL
         prV4JElEDEL2yYI1HjhVw9IdnXVfVJT/b2wX4AIY0OhjSob2XhHr5Ot0p8ff9gd2fePz
         4Fa5DEflbJRrIcH6w1xEtTjkUNL62g8uA03PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709067323; x=1709672123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKCWCT93031ctnu4e0l2nLLoQn5zgMFTn2j+yBK/CsE=;
        b=OEoxFZDGGPXFOAhfJqHM2UnNyeZ5AwpTwMsREeJkabsQ3OFT+bwV+drKwQL25ISsyc
         ue12zCYWtsfea4iZLPkN0/blITN7ZGTHfuQzghdN1JEXXYe8JgDJATv3Aa7sgVXjwh3l
         r2Dkrr42Xj1ITfgT2IR7bJT/SCOTR41LuTRvNUjogm0keP5/s7QcxvoII2KENsIzRlMC
         lFfcjl9tBMP1roY5cI5XhRjOfe9wmbUhuTBYlpJnV57/o1Q9CSThIVWDrQF59umduDLG
         zdNuabV+vwPHLExNw9uzFjFB15kNlQ1cqXw+elcA+sgOQHN2nsHO9nKhYVLTcf7OWftW
         xlgA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ0lrJcx25fDHiX9dg+v/JrX2e7pCF0YwEG3RH7UAK4Ii/du3Nu/xE7F5pmPzB6wdPzqwUSErVqFH+cTxEYAc1TtcSMO8Opw4WlyNT
X-Gm-Message-State: AOJu0YzFG/6pcDnyVwekzg+k9JXTZv2dP1Q85tArlJ0+urDyEFjosv3L
	4p8SmJr2vACpsfOXZ6hbucP/RnhvuglhDEMDB+as7e8rQ5i6zX21fH+P72dhe4QTjw5csSFdV1h
	/B7r8Rw==
X-Google-Smtp-Source: AGHT+IFaAuZ/WKGwX2S+LRFp91tl6zrRlhEoOBVChFAwksD1TDXu5n2CwbRwAwdq+NiDnTv68vtX4g==
X-Received: by 2002:a17:906:a3cd:b0:a43:3b32:3906 with SMTP id ca13-20020a170906a3cd00b00a433b323906mr5432454ejb.27.1709067323514;
        Tue, 27 Feb 2024 12:55:23 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id j3-20020a1709062a0300b00a3e799969aesm1104174eje.119.2024.02.27.12.55.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 12:55:22 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3e7ce7dac9so540186666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:55:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwS1es7+zmBEJk7hn59/dgYdYMYYimgY2dSMyhtBdJWW5O/TnXJFNBsJdFJmgYEogsbcy07Q67wIBdZpCj2XnGzLFriNHM1VS4+Heg
X-Received: by 2002:a17:906:aed1:b0:a43:dbd6:6862 with SMTP id
 me17-20020a170906aed100b00a43dbd66862mr957734ejb.73.1709067322332; Tue, 27
 Feb 2024 12:55:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com>
 <170905254443.2268463.935306988251313983.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170905254443.2268463.935306988251313983.stgit@dwillia2-xfh.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Feb 2024 12:55:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBVhnh=KSeBBRet=E7qJAwnPR_aj5em187Q3FiD+LXnA@mail.gmail.com>
Message-ID: <CAHk-=whBVhnh=KSeBBRet=E7qJAwnPR_aj5em187Q3FiD+LXnA@mail.gmail.com>
Subject: Re: [PATCH 3/3] cxl/region: Use cond_guard() in show_targetN()
To: Dan Williams <dan.j.williams@intel.com>
Cc: peterz@infradead.org, gregkh@linuxfoundation.org, 
	Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 08:49, Dan Williams <dan.j.williams@intel.com> wrote:
>
> -       rc = down_read_interruptible(&cxl_region_rwsem);
> -       if (rc)
> -               return rc;
> +       cond_guard(rwsem_read_intr, return -EINTR, &cxl_region_rwsem);

Yeah, this is an example of how NOT to do things.

If you can't make the syntax be something clean and sane like

        if (!cond_guard(rwsem_read_intr, &cxl_region_rwsem))
                return -EINTR;

then this code should simply not be converted to guards AT ALL.

Note that we have a perfectly fine way to do conditional lock guarding
by simply using helper functions, which actually makes code MORE
READABLE:

        if (!down_read_interruptible(&cxl_region_rwsem))
                return -EINTR;
        rc = do_locked_function();
        up_read(&cxl_region_rwsem);
        return rc;

and notice how there are no special cases, no multiple unlocks, no
NOTHING. And the syntax is clean.

Honestly, if people are going to use 'guard' to write crap code, we
need to really stop that in its tracks.

There is no upside to making up new interfaces that only generate garbage.

This is final. I'm not willing to even entertain this kind of crap.

                     Linus

