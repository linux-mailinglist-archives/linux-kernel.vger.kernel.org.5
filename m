Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8A27BEBCD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378001AbjJIUmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjJIUmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:42:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD9792
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:42:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c5c91bece9so35712825ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 13:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696884135; x=1697488935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jQQInxgsjBt8w5xcxIPIHbM5AYNFsiZIBl4w68pdIx8=;
        b=Wu+000MO5t3eBFYqm22mZBbmq8jg7gvPF00LNVrW5E0kJlsEJL3c18fdwsSNzRehm9
         kAO/9ugiSIt6CTMutB999b+SOmUl8BEpvRLAxv4esa0OfQaHbgboDsckZ0ToUCk3jimg
         C7zE/Its3EVqTcbDo8+wel28Z66Mpk14wKyoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696884135; x=1697488935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQQInxgsjBt8w5xcxIPIHbM5AYNFsiZIBl4w68pdIx8=;
        b=tAeuDBylVHkATcYwYbTSX5LgqSJYucRFqrsdhEeLFVxk91YAlJvKJODUliBP9N4fJ0
         CtRPqHOr+hX4UJORvp8dyd6MuXlgb9Rrkxm/q/Qv2NjOqMsZhpNTVbzSIHjQrq1O5BQe
         A+I6bv1+3qnDGOPJkaHwxQFDkIhTx/xCGdjjuV8ttmOZqTECiGYtBrZNpt5e/gVZIeTu
         l9Ep2bV7FQsMwQn7S2Sz8mo7LeA+EvHjJwE0AdsevqAGExKIiLAru2SewbEaHakt3p9X
         qEUiqOkxgyst7gOTuh1iVj508LXJjLUXrT42J57b4djXKNEGcu7k4WRDIPiP+9DsjmQd
         KLRA==
X-Gm-Message-State: AOJu0YysZMhqPJSWa835Bawz+knxjEHhacXs1rYh6Bmicjkk16jgnuz/
        wa1IP7Zdd+phxfOk1oorXip/3o8SYGqNSe5M4hc=
X-Google-Smtp-Source: AGHT+IH9MdMNUUJjdaGAliL795A9zatzD6Si8kgw2QUoHjHiomp879pl81fC008rIbxKA5Jr3etkHA==
X-Received: by 2002:a17:902:e883:b0:1c6:19da:b29f with SMTP id w3-20020a170902e88300b001c619dab29fmr16439549plg.26.1696884135372;
        Mon, 09 Oct 2023 13:42:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709027fca00b001c465bedaccsm10286698plb.83.2023.10.09.13.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:42:14 -0700 (PDT)
Date:   Mon, 9 Oct 2023 13:42:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] hostap: Add __counted_by for struct
 prism2_download_data and use struct_size()
Message-ID: <202310091341.74A2D82BB@keescook>
References: <ZSRXXvWMMkm7qqRW@work>
 <202310091253.665A9C9@keescook>
 <169f782e-9cc4-49bc-9618-ca6acc526e37@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169f782e-9cc4-49bc-9618-ca6acc526e37@embeddedor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 02:33:01PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 10/9/23 21:54, Kees Cook wrote:
> > On Mon, Oct 09, 2023 at 01:41:18PM -0600, Gustavo A. R. Silva wrote:
> > > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > > attribute. Flexible array members annotated with __counted_by can have
> > > their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> > > array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > > functions).
> > > 
> > > While there, use struct_size() helper, instead of the open-coded
> > > version, to calculate the size for the allocation of the whole
> > > flexible structure, including of course, the flexible-array member.
> > > 
> > > This code was found with the help of Coccinelle, and audited and
> > > fixed manually.
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > >   drivers/net/wireless/intersil/hostap/hostap_download.c | 3 +--
> > >   drivers/net/wireless/intersil/hostap/hostap_wlan.h     | 2 +-
> > >   2 files changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/net/wireless/intersil/hostap/hostap_download.c b/drivers/net/wireless/intersil/hostap/hostap_download.c
> > > index 3672291ced5c..5e5bada28b5b 100644
> > > --- a/drivers/net/wireless/intersil/hostap/hostap_download.c
> > > +++ b/drivers/net/wireless/intersil/hostap/hostap_download.c
> > > @@ -732,8 +732,7 @@ static int prism2_download(local_info_t *local,
> > >   		goto out;
> > >   	}
> > > -	dl = kzalloc(sizeof(*dl) + param->num_areas *
> > > -		     sizeof(struct prism2_download_data_area), GFP_KERNEL);
> > > +	dl = kzalloc(struct_size(dl, data, param->num_areas), GFP_KERNEL);
> > >   	if (dl == NULL) {
> > >   		ret = -ENOMEM;
> > >   		goto out;
> > > diff --git a/drivers/net/wireless/intersil/hostap/hostap_wlan.h b/drivers/net/wireless/intersil/hostap/hostap_wlan.h
> > > index c25cd21d18bd..f71c0545c0be 100644
> > > --- a/drivers/net/wireless/intersil/hostap/hostap_wlan.h
> > > +++ b/drivers/net/wireless/intersil/hostap/hostap_wlan.h
> > > @@ -617,7 +617,7 @@ struct prism2_download_data {
> > >   		u32 addr; /* wlan card address */
> > >   		u32 len;
> > >   		u8 *data; /* allocated data */
> > > -	} data[];
> > > +	} data[] __counted_by(num_areas);
> > >   };
> > 
> > Should this be considered a v2 of:
> > https://lore.kernel.org/linux-hardening/94848cc3-6f5c-46d7-8cc7-98a4f10865b3@embeddedor.com/
> > 
> > ?
> 
> Oops... sorry, I forgot I had reviewed this patch of yours.
> 
> > 
> > Yours is more complete since it includes the struct_size() change...
> > 
> 
> Should I resend this explicitly marking it as a v2?

I defer to Kalle -- your Subject is more accurate, so perhaps let's just
let this stand?

-- 
Kees Cook
