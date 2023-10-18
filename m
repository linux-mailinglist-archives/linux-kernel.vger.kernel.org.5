Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FF37CEB60
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjJRWgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjJRWgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:36:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A8011C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:36:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9d407bb15so62379055ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697668562; x=1698273362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gU8UgFLtIwBMnNin+UfjeLA6KRbmnG6Wd91XkYWntpA=;
        b=GQhkVl/9fDceZRGSVUreqYnt3zuY5DMfBTEFTanW2ex901gUNulYVNrrmdTLIvHRt7
         w54JVgMxU+iBiWwDff9UJNcaBR6Dyixjer5sedl1HZc/Vt5DHZLrAMffHaHQyWUOYFYS
         Sq/fV1rqYB1Sjq5yIIjAdwZqeYPzg/ybbts/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697668562; x=1698273362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gU8UgFLtIwBMnNin+UfjeLA6KRbmnG6Wd91XkYWntpA=;
        b=MyTVcbNx26dTsXF3R0kaCICC1GvTDGaWMzwOzQ9U8+UNg/nGAE4/YNGNed2iXWykXi
         HBzUeblPXQYxD7pJLkFNrnzdi4Vha1TEOltRg/iwfcfIoKD9Qz6l3pm6vl4IXF5uap2Y
         DY+mXU9mOUry13v6eDdRF1ONIeKL9HZPrFdkbSxonE3T+Cagwla6amPB6Ec9CZor9AV0
         eyHCzZuYYo+LM8UxunJ7IHWGiE3uPgmsNJGdt611ycHoU1DvxivBFrdR7zSq3AdPsue3
         vdDlncqxuKrLFKzbyICaAD2/xMXVTRFMwLAlgO8fx3qXyfKYuXGXgGEn0o0GIEyNSRkA
         VvEQ==
X-Gm-Message-State: AOJu0YxyngBL5CaMfqYOGJuKw7qOAUa9iC+xZRhLnMLlGn+12n7afoId
        qWW7HR85vPBNZ5wKgI+jYZGgyQ==
X-Google-Smtp-Source: AGHT+IHZ7D6QAbuRry6EjRTPblbyH23khZ4i/P+R2xOAqDQmfqYJkoXHgkb29YoqYPno7OWAy5G2/Q==
X-Received: by 2002:a17:903:2342:b0:1c7:5f03:8562 with SMTP id c2-20020a170903234200b001c75f038562mr729819plh.30.1697668561892;
        Wed, 18 Oct 2023 15:36:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iw6-20020a170903044600b001c0a414695dsm453085plb.62.2023.10.18.15.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 15:36:01 -0700 (PDT)
Date:   Wed, 18 Oct 2023 15:36:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Refactor bkey_i to use a flexible array
Message-ID: <202310181534.54934E68@keescook>
References: <20231010235609.work.594-kees@kernel.org>
 <ZSkpU0vdrCTfTxuZ@bfoster>
 <202310131637.D0C66BFBA@keescook>
 <20231018220407.b5dvm2ehibcqvhzq@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018220407.b5dvm2ehibcqvhzq@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 06:04:07PM -0400, Kent Overstreet wrote:
> On Fri, Oct 13, 2023 at 04:44:21PM -0700, Kees Cook wrote:
> > On Fri, Oct 13, 2023 at 07:26:11AM -0400, Brian Foster wrote:
> > > Hi Kees,
> > > 
> > > I'm curious if this is something that could be buried in bch_val given
> > > it's already kind of a fake structure..? If not, my only nitty comment
> > 
> > I was thinking it would be best to keep the flexible array has "high" in
> > the struct as possible, as in the future more refactoring will be needed
> > to avoid having flex arrays overlap with other members in composite
> > structures. So instead of pushing into bch_val, I left it at the highest
> > level possible, bch_i, as that's the struct being used by the memcpy().
> 
> I agree with Brian here - I'd like this buried in bch_val, if possible.
> 
> I also went with unsafe_memcpy() for now - that's now in my for-next
> tree. I'm not seeing any advantage of DECLARE_FLEX_ARRAY over that -
> perhaps later if we could use __counted_by that would make more sense.

This won't help here because of the combination of -fstrict-flex-arrays=3
and -Wstringop-overflow (the latter is in W=1 builds). The builtin memcpy
still complains about the 0-sized destination. I'll send a v3 with this
in bch_val.

-- 
Kees Cook
