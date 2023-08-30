Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3276C78E257
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343818AbjH3Wbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239250AbjH3Wbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:31:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066C510D5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:31:13 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a3f1d8be2so144208b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693434671; x=1694039471; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wLDN7invAXGpseGpdDIIZ1SIKjfNtH5ZhUlLs7bFFN0=;
        b=G+D+893AUA3w7U7FwsSee1/qSn5MIl3e5oCnBQwN+SvV4FlCbIY6NZJRTkrGOyq+Kq
         huqtpO3Q/73VrRzkX2bC4W355wngK8EPdj0yjWmC4b9PAWUS3s5NCqQnamY80LkkwiCL
         wdhsSEdRxT0/xzIcgM48yv2sb1o83+tOGXztk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693434671; x=1694039471;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLDN7invAXGpseGpdDIIZ1SIKjfNtH5ZhUlLs7bFFN0=;
        b=Kx4/s4FtFAjWyNaQk3x789tfUnRZsEDqKowUmO86xoe5DkRrtpG0dkzhZdZY9mivjl
         4+ukhq0CQIw0zbmO145p2SsBzAF64RUoGgkG+92YP3PBluTxWZCeCAj6Rb4D9c6dvzay
         rFaUTbdR2pEe5Ygm0pRNnLld3yw6dZMvlTzOrbIjTF+/35NJyfl5W9WUqDKqVAFIoQrR
         IYl71C9bSXAu4gewmHU9gcJuSzCHd0vxREUqe4p0XtF1QTGQgtYuc3Lc0rPvtDfVzeKJ
         BvdUje1bNQL7uslA6jeBryskQ497JkQIqHo0a7RxCxWxbsVXz9NTlHxxWCcE1pnTQLCH
         ygEA==
X-Gm-Message-State: AOJu0YwxPP1CiVx8vsBYc2cOhiNEJH/Es9/ckSdwZKyv4//qIQE6CmTV
        XTAh54wzhepnuXKwItBVlDnRBw==
X-Google-Smtp-Source: AGHT+IHrlwyuuGG2TNqsxkvlcHDbOA6H/Roidvdt8I8o1ntXeNMScdFrJueXW8h5EV6g+ONFbgkLTQ==
X-Received: by 2002:a05:6a00:189b:b0:68c:638b:e2c6 with SMTP id x27-20020a056a00189b00b0068c638be2c6mr4193982pfh.9.1693434671611;
        Wed, 30 Aug 2023 15:31:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p22-20020a62ab16000000b006870721fcc5sm73775pff.175.2023.08.30.15.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 15:31:11 -0700 (PDT)
Date:   Wed, 30 Aug 2023 15:31:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Christian Lamparter <chunkeey@gmail.com>, kernel@quicinc.com,
        Kalle Valo <kvalo@kernel.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mac80211: Use flexible array in struct
 ieee80211_tim_ie
Message-ID: <202308301529.AC90A9EF98@keescook>
References: <20230829-ieee80211_tim_ie-v2-0-fdaf19fb1c0e@quicinc.com>
 <20230829-ieee80211_tim_ie-v2-2-fdaf19fb1c0e@quicinc.com>
 <1774098a-5062-4f12-a760-f16036d095e3@gmail.com>
 <9da7f41e-6d4a-452a-8042-0b09cad71bb8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9da7f41e-6d4a-452a-8042-0b09cad71bb8@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 01:22:37PM -0700, Jeff Johnson wrote:
> On 8/30/2023 12:51 PM, Christian Lamparter wrote:
> > Hi,
> > 
> > On 8/29/23 15:29, Jeff Johnson wrote:
> > > Currently struct ieee80211_tim_ie defines:
> > >     u8 virtual_map[1];
> > > 
> > > Per the guidance in [1] change this to be a flexible array.
> > > 
> > > As a result of this change, adjust all related struct size tests to
> > > account for the fact that the sizeof(struct ieee80211_tim_ie) now
> > > accounts for the minimum size of the virtual_map.
> > > 
> > > [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> > > 
> > > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > > ---
> > > diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> > > index bd2f6e19c357..4cdc2eb98f16 100644
> > > --- a/include/linux/ieee80211.h
> > > +++ b/include/linux/ieee80211.h
> > > @@ -961,7 +961,7 @@ struct ieee80211_tim_ie {
> > >       u8 dtim_period;
> > >       u8 bitmap_ctrl;
> > >       /* variable size: 1 - 251 bytes */
> > > -    u8 virtual_map[1];
> > > +    u8 virtual_map[];
> > >   } __packed;
> > 
> > 
> > Uhh, the 802.11 (my 2012 Version has this in) spec in
> > 8.4.2.7 TIM Element demands this to be 1 - 251 bytes.
> > And this is why there's a comment above... With your
> > change this could be confusing. Would it be possible
> > to fix that somehow? Like in a anonymous union/group
> > with a flexible array and a u8?
> 
> Adding Kees to the discussion for any advice. Yes, the virtual_map must
> contain at least one octet but may contain more than one. And to complicate
> matters, the information that tells us how many octets are actually present
> is found outside the struct; the TLV header that precedes the struct will
> contain the length of the struct, and hence the length of the bitmap is that
> size - 2 (the size of the dtim_period and bitmap_ctrl fields).

Bummer about the count variable being elsewhere, but we'll deal with
that later. :)

For the array declaration, though, yes, we can do a "minimum size 1" like
this:

	union {
		u8 required_byte;
		DECLARE_FLEX_ARRAY(u8, virtual_map);
	};

-- 
Kees Cook
