Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A887F0A83
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 03:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjKTCT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 21:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTCT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 21:19:57 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC01139
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 18:19:53 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cb90b33c1dso228879b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 18:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700446793; x=1701051593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdcAy7f6OnqVo5w9nQ2q1tLDxqo/b/Mq58x7mmCIVdQ=;
        b=LHVd0oJR77piZdhcFHW2B5xjZ9ZZKgvES3yFhMTPdGDF75TCQPU+i7ISeuJEXUlHQH
         V/fADTTK8IA2KhvXxaksorYD0TWotzQ2VZYSwfknZb+FuYOLomPIiKMORmU5Xf1qSVLp
         QotmF6aXcBqI6/1J7dloyZ2RXSa1TPHYhV5VrEq4JG92ryFWigBn7qiY5wnbRHrENSiu
         o70Q0QZvW3sjB0QgTJvZZGr7Mp4/Ef8V3+hoDFes+5dhN8F+DKrMpkVs8JaJiJBgaqDd
         0Lf+Q6A4ZDG0mq0pZYfFkOxwnqPIeuJgPPpc9lV0R0/HcFN5F6NFzuU3OzjNsnhtpBaK
         TQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700446793; x=1701051593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdcAy7f6OnqVo5w9nQ2q1tLDxqo/b/Mq58x7mmCIVdQ=;
        b=T5S2cnBVg7hRBV5RkJNyzC1TCc1pKzuKUhThaOwDJ2vHgsnkw8ZRus1dyHtZfmnXfo
         0pDK6y3g8HrXuCLl2v2+TNaI6UtUPyCJwpqXij052VVNMTqQt7TeURJfgMt9Zcc7yP8y
         1AGAdpXuNIRi5n9aaWHVAwirxAsnAxpI61IeZy0pzAvQvpWjYG/ez7wvKVjyy5AbqQAC
         cj74KoSUd44Kgk/+7SC5+LgnVcp8+bOF4wJpPdhVg9R+0BAAZlB6AXY7c2PUKeCdjK97
         e7Ro4c0rJVz4hyBNqWtPEMdr+w6j/jXFgIC6XIMwPqij84CyBobGu2cHtMjbj1HtNokX
         ZaaQ==
X-Gm-Message-State: AOJu0YyBQK0Ufx2sLYzh0oZ7nlysW+bhJKcKakdXLhen9dkm5Hl1LBbq
        6HMJYL1EURtf8zBFfG+MUdQpHw==
X-Google-Smtp-Source: AGHT+IEGL27jcOecfkEXSzT46jeep5qjXQSjSRMeMi2Pno023MFnh2RelKymNsSgTt8dDccEibQN4w==
X-Received: by 2002:a17:902:da8e:b0:1cc:27fa:1fb7 with SMTP id j14-20020a170902da8e00b001cc27fa1fb7mr7935283plx.5.1700446792822;
        Sun, 19 Nov 2023 18:19:52 -0800 (PST)
Received: from fedora.localnet ([240d:1a:3a7:a400:9a57:aa11:487a:b54f])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f7d200b001cf5d425244sm1013801plw.298.2023.11.19.18.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 18:19:52 -0800 (PST)
From:   Ryosuke Saito <ryosuke.saito@linaro.org>
To:     Simon Horman <horms@kernel.org>
Cc:     jaswinder.singh@linaro.org, ilias.apalodimas@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, masahisa.kojima@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: netsec: replace cpu_relax() with timeout handling for
 register checks
Date:   Mon, 20 Nov 2023 11:19:48 +0900
Message-ID: <5027002.31r3eYUQgx@fedora>
In-Reply-To: <20231119185337.GE186930@vergenet.net>
References: <20231117081002.60107-1-ryosuke.saito@linaro.org>
 <20231119185337.GE186930@vergenet.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend again after removing an HTML format. Sorry for that.]

Hi Simon-san,

On Mon, Nov 20, 2023 at 3:53 AM Simon Horman <horms@kernel.org> wrote:
>
> On Fri, Nov 17, 2023 at 05:10:02PM +0900, Ryosuke Saito wrote:
> > The cpu_relax() loops have the potential to hang if the specified
> > register bits are not met on condition. The patch replaces it with
> > usleep_range() and netsec_wait_while_busy() which includes timeout
> > logic.
> >
> > Additionally, if the error condition is met during interrupting DMA
> > transfer, there's no recovery mechanism available. In that case, any
> > frames being sent or received will be discarded, which leads to
> > potential frame loss as indicated in the comments.
> >
> > Signed-off-by: Ryosuke Saito <ryosuke.saito@linaro.org>
> > ---
> >  drivers/net/ethernet/socionext/netsec.c | 35 ++++++++++++++++---------
> >  1 file changed, 23 insertions(+), 12 deletions(-)
>
> ...
>
> > @@ -1476,9 +1483,13 @@ static int netsec_reset_hardware(struct netsec_priv 
*priv,
> >       netsec_write(priv, NETSEC_REG_DMA_MH_CTRL, MH_CTRL__MODE_TRANS);
> >       netsec_write(priv, NETSEC_REG_PKT_CTRL, value);
> >
> > -     while ((netsec_read(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) &
> > -             NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0)
> > -             cpu_relax();
> > +     usleep_range(100000, 120000);
> > +
> > +     if ((netsec_read(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) &
> > +                      NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0) {
> > +             dev_warn(priv->dev,
> > +                      "%s: trans comp timeout.\n", __func__);
> > +     }
>
> Hi Saito-san,
>
> could you add some colour to how the new code satisfies the
> requirements of the hardware?  In particular, the use of
> usleep_range(), and the values passed to it.


For the h/w requirements, I followed U-Boot upstream:
https://elixir.bootlin.com/u-boot/latest/source/drivers/net/sni_netsec.c

It has the same function as well, netsec_reset_hardware(), and the 
corresponding potion is the following read-check loop:

1012         value = 100;
1013         while ((netsec_read_reg(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) 
&
1014                 NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0) {
1015                 udelay(1000);
1016                 if (--value == 0) {
1017                         value = netsec_read_reg(priv, 
NETSEC_REG_MODE_TRANS_COMP_STATUS);
1018                         pr_err("%s:%d timeout! val=%x\n", __func__, 
__LINE__, value);
1019                         break;
1020                 }
1021         }

The maximum t/o = 1000us * 100 + read time

Regards,
Ryo 


