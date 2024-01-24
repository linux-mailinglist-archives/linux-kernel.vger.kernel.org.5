Return-Path: <linux-kernel+bounces-36265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB940839E22
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8544328D50E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225E0137C;
	Wed, 24 Jan 2024 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="ZJraEpcl"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B6EC5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706059139; cv=none; b=Hp3pbg3Izu2qivILu7QM4O1+xUA0DQEgfL7JlluET5nWsgOOGwHVPV92mhWEllTQCPjyhPLG8n3Pcdx5uCC+25MGcAsArSzizPLbAZ7/4TmdAvzNsOEbk4+Oc8/dh1mpK8oWfyYtLF8Yeqf4okY9jGvSRxzOBuMj34UO73TH0+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706059139; c=relaxed/simple;
	bh=t/X1nR/dlSd60tJeBcYC4x/1XABmgwxC0l6zCDXYUv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPKgcZ6xYmTzwvvwuOeT9VB4YYgASNE+S5DJysK1O5Z/Gk4HLHqc7TJSICe0zBZbccp8CoYRn3zOl7laDHPRMCL2Q/pylNcGF0wTQ0JB0X4EnmOiHmvQzOo2+9Evf7SSFkj27EzrfHWjq6h0nES7E8Vz2px6MFvC+2M8cSRCOTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=ZJraEpcl; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68196a09e2eso29806346d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1706059133; x=1706663933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzOCm5wYtnoBm7flYhqkMXyh0L013AvfZt8QYlUBMZc=;
        b=ZJraEpcli65wTDLCGC1/IIV/etji4CvJWjGWb0oURfX0ZP9Q+Bb+l0PSwi47XeuRKI
         wYWhES8l8+GerEqiqNfYsOJrzbqPy/WyzIwiTrK8jG0jAQ4e+NOZGNXK4X6XO0vflvkJ
         O4Msrw/2StO7bgoZoeA24DMCZI1iyqvJpL4nEWCwOAQC7Mt/C19XbnOyXbsHeWYK+Yxp
         cegqUowO3lG5FeN8JuPboON0bye5DUNJngSORYyDxAxZdfg93+RztqpDAT0yJ968M+vI
         DPNxV2jBjQg+OZoNQ904HmPXsFtEopmMyPKlaewg+615+TBbwOIxbf5LIrggrXg14EZ5
         DDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706059133; x=1706663933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzOCm5wYtnoBm7flYhqkMXyh0L013AvfZt8QYlUBMZc=;
        b=fd/NmX9JM78pt1fFrjrcFMnrWvt7Kh+7QMx4MgkJoYa+zXTziMBjIsc2tBd2ZKKbaZ
         f5+wgLBnpn8V34ms2+Ch4PS+mQ0neyI2dp5mD9jHrCS4WEDtfjRFWkqcu53wAS0ko2Ui
         ayfvHSgzMMKcH+Eu/TuCuXxrUIZe6szQD6aCfiPcLJfwqEzl5hi/ShsH7irE/rvN94Gx
         A6OefQbZfeJpT5YiVaBjUVSZVlWIJ/yrhFpt2TLzs8gBGYo1rf4SIRxH7xDWMbTVFEJO
         XAD3OrrlqgNdChalts9+La7Y2xKaPjSE2Ks2sLq+xqSAIHowwG2AZ9I3VrDyb16QexKU
         XX5Q==
X-Gm-Message-State: AOJu0YxPwCaA1x9DuxTYlecFXO3MoqrGNRG8FW8PM3TTGPcGSW3SeP6G
	8ZIn4Nl2UqEPtTLPkynVDeClq3MYSym6NFIqqIrQoYyK1kNlRQ9QpNZOpYpsiLHi+/hOJouGn7s
	=
X-Google-Smtp-Source: AGHT+IGReTPF9uro0MMPnXtuBwx9j2YPj4LtLfgv/x5LMGd9mJj2i35gtn4P0JCrtdAZdMJIepVXzg==
X-Received: by 2002:a05:6214:5186:b0:685:56e3:cb90 with SMTP id kl6-20020a056214518600b0068556e3cb90mr2358485qvb.26.1706059133009;
        Tue, 23 Jan 2024 17:18:53 -0800 (PST)
Received: from cs.cmu.edu (hurricane.elijah.cs.cmu.edu. [128.2.209.191])
        by smtp.gmail.com with ESMTPSA id ma8-20020a0562145b0800b00686a0102df9sm1191328qvb.128.2024.01.23.17.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 17:18:52 -0800 (PST)
Date: Tue, 23 Jan 2024 20:18:50 -0500
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fs: coda: Remove unused variable 'outp' in
 venus_rmdir
Message-ID: <20240124011850.h46azfxgrzvyttzv@cs.cmu.edu>
References: <20240124010322.94782-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124010322.94782-1-yang.lee@linux.alibaba.com>

Thank you, but you sent the same patch in April 2021 and it resulted in
compile errors in the expansion of UPARG.

I assume this one will result in the same errors.

Jan


    [auto build test ERROR on linus/master]
    [also build test ERROR on v5.12-rc5 next-20210401]
    [If your patch is applied to the wrong git tree, kindly drop us a note.
    And when submitting patch, we suggest to use '--base' as documented in
    https://git-scm.com/docs/git-format-patch]

    url:
    https://github.com/0day-ci/linux/commits/Yang-Li/coda-Remove-various-instances-of-an-unused-variable-outp/20210402-173111
    base:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    1678e493d530e7977cce34e59a86bb86f3c5631e
    config: arc-randconfig-r014-20210402 (attached as .config)
    compiler: arceb-elf-gcc (GCC) 9.3.0
    reproduce (this is a W=1 build):
            wget
    https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
    -O ~/bin/make.cross
            chmod +x ~/bin/make.cross
            # https://github.com/0day-ci/linux/commit/b6484bc8a589df437829010ab82b49c48d56ee46
            git remote add linux-review https://github.com/0day-ci/linux
            git fetch --no-tags linux-review
    Yang-Li/coda-Remove-various-instances-of-an-unused-variable-outp/20210402-173111
            git checkout b6484bc8a589df437829010ab82b49c48d56ee46
            # save the attached .config to linux build tree
            COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross
    ARCH=arc

    If you fix the issue, kindly add following tag as appropriate
    Reported-by: kernel test robot <lkp@intel.com>

    All errors (new ones prefixed by >>):

       fs/coda/upcall.c: In function 'venus_setattr':
    >> fs/coda/upcall.c:65:9: error: 'outp' undeclared (first use in this
    >> function); did you mean 'outl'?
          65 |         outp = (union outputArgs *)(inp); \
             |         ^~~~
       fs/coda/upcall.c:118:2: note: in expansion of macro 'UPARG'
         118 |  UPARG(CODA_SETATTR);
             |  ^~~~~
       fs/coda/upcall.c:65:9: note: each undeclared identifier is reported
    only once for each function it appears in
          65 |         outp = (union outputArgs *)(inp); \
             |         ^~~~


On Wed, Jan 24, 2024 at 09:03:22AM +0800, Yang Li wrote:
> The variable 'outp' is declared but not used in the venus_rmdir
> function within the Coda filesystem module. This causes a compiler
> warning about the variable being set but not used.
> 
> To clean up the code and address the compiler warning, this patch
> removes the declaration of the unused 'outp' variable.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/coda/upcall.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
> index cd6a3721f6f6..d97e0e4374f9 100644
> --- a/fs/coda/upcall.c
> +++ b/fs/coda/upcall.c
> @@ -303,7 +303,6 @@ int venus_rmdir(struct super_block *sb, struct CodaFid *dirfid,
>  		    const char *name, int length)
>  {
>          union inputArgs *inp;
> -        union outputArgs *outp;
>          int insize, outsize, error;
>          int offset;
>  
> -- 
> 2.20.1.7.g153144c
> 
> 

