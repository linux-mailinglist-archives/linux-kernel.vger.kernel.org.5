Return-Path: <linux-kernel+bounces-301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D85813EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE741C22041
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC12806;
	Fri, 15 Dec 2023 01:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Coh5tL+X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C336A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-58dd3528497so150318eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 17:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702602136; x=1703206936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JkruKU4a5bjXzJWOR3RC/txskZKPO+PmORU8eDBqdN8=;
        b=Coh5tL+XJtCFKgsf8NNqA/FZt5stJC1tADMa4UaOmNnQMTXc/Ll5Qj7v4qSSl9hmEd
         CX6OABf8bvWijjSRoJ8JTL7fSPJiMne0GEEoOJ6Zn9Qqixx9SnsBj6LkvDDvUbohgfhI
         qhYOtGdAwihQ1VBVVlmbXQHz1fNhQYmce/ziI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702602136; x=1703206936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkruKU4a5bjXzJWOR3RC/txskZKPO+PmORU8eDBqdN8=;
        b=ZRpgUhvMRIRqzGbZDMZ1B9bUubcy9AHRSu/FpEka76RJY2QqdC6ZpL0+mMq5rLamfu
         IBRfcSEj01FTInCJ4tq7ZjU+ivC+LatTE1Mo2ZDto1Lax0JoQZyylBxYJZnZjI0lCDZM
         CnTPhAIGzFoL5fzc1yJHbt+BD7y1XZctu2Pp2g2fncVuPF+KlvtKT1sLW/49jSrddf+9
         6/gtXb7XBfD/6yFSnyyAIT3UmfDZTwuPeuh4T1BFysQpXXkGJ2i4iKs/1aAihWghvSrP
         xBB0niWJ4ru3TDQTjkhy+oq7MrPTvco5myI+/qyaQbrYadEwB2ebn6ZWs7wi5jsRntjp
         ZYzg==
X-Gm-Message-State: AOJu0Yw/1ayuEa09Oc1Fo7dA3xwRVYGFIWnEUC+UY7z7/jChKLf/Ipy9
	wV8YJmjeppZ2Gsu3SOJAryGYZtv9sKm2K2ZHxbM=
X-Google-Smtp-Source: AGHT+IHHSlfuVuFLEbWp0S1w35rpI8fafNVNhJmQK3Uu3c1zhb4GOk4bGqarOHhYFza7b+HShr1s6A==
X-Received: by 2002:a05:6358:7e45:b0:170:f329:74bb with SMTP id p5-20020a0563587e4500b00170f32974bbmr4719923rwm.44.1702602136471;
        Thu, 14 Dec 2023 17:02:16 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e14-20020a056a001a8e00b006ce6bd9703csm12227711pfv.194.2023.12.14.17.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 17:02:15 -0800 (PST)
Date: Thu, 14 Dec 2023 17:02:15 -0800
From: Kees Cook <keescook@chromium.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] scripts/kernel-doc: restore warning for Excess
 struct/union
Message-ID: <202312141701.DD74B450B@keescook>
References: <20231214070200.24405-1-rdunlap@infradead.org>
 <bd003104-f09a-4904-90ce-ade286a2d051@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd003104-f09a-4904-90ce-ade286a2d051@infradead.org>

On Wed, Dec 13, 2023 at 11:05:42PM -0800, Randy Dunlap wrote:
> (correcting Mauro's email address)
> 
> 
> On 12/13/23 23:02, Randy Dunlap wrote:
> > The warning for Excess struct or union member description was
> > removed when the $nested parameter of check_sections() was removed.
> > This causes some kernel-doc notation warnings to be missed.
> > 
> > Recently the kernel test robot somehow reported an Excess member. The
> > code in kernel-doc has not issued that warning since kernel v4.16, so I
> > don't know how the robot did it. (See the Link for the report.)
> > 
> >   drivers/net/wireless/intel/iwlwifi/fw/dbg.c:86: warning: Excess struct/union/enum/typedef member 'trans_len' description in 'iwl_fw_dump_ptrs'
> > 
> > I patched that warning away even though I could not reproduce the
> > warning from kernel-doc. The warning should be issued for extraneous
> > struct member or union member description, so restore it.
> > 
> > Fixes: 1081de2d2f91 ("scripts: kernel-doc: get rid of $nested parameter")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Link: https://lore.kernel.org/all/202312060810.QT9zourt-lkp@intel.com/
> > Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org
> > ---
> >  scripts/kernel-doc |    7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff -- a/scripts/kernel-doc b/scripts/kernel-doc
> > --- a/scripts/kernel-doc
> > +++ b/scripts/kernel-doc
> > @@ -1659,6 +1659,13 @@ sub check_sections($$$$$) {
> >  					"'$sects[$sx]' " .
> >  					"description in '$decl_name'\n");
> >  			}
> > +			elsif (($decl_type eq "struct") or
> > +		       	       ($decl_type eq "union")) {
> > +				emit_warning("${file}:$.",
> > +					"Excess $decl_type member " .
> > +					"'$sects[$sx]' " .
> > +					"description in '$decl_name'\n");
> > +			}
> >  		}
> >  	}
> >  }

Yes, please!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

