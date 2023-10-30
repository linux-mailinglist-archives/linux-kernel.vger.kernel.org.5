Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050717DC263
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjJ3WUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjJ3WUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:20:42 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C9D110;
        Mon, 30 Oct 2023 15:20:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40850b244beso38746635e9.2;
        Mon, 30 Oct 2023 15:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698704437; x=1699309237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwrn6ID3BUu3z/5xyPAOjQ/FmaKW4prpre5IoiNlsn4=;
        b=d/1FaI2DGYYdGx2SB+bq+8yeLnL7F1tS90Zom40hblMQrCNqymbHYsQ5UEvxZNwzmW
         0eMQB+Ce0w2Plf6wVOUFk/9Oyo3FjNr4qTaXmCXYTnH3fZGr3z5BWcnUAUvPoNhISDSE
         hC4FdzPQV/TqujUSvmkliEBbvNYAuuPmvdTQf2WsHEUOht7L+V/yOxrmfPCJje9zmz2y
         zOlK6+wFbHzyPd4RVlGkM7vZRjgSG1VbeB4ccwYZ0LnYAlcyd7kM9LMebzC8rCgJcr5p
         S6+0NMZM6LCs1bN0wVtB2LEtzCfwqdZJcAaGCAwyXiahiywPQ8Ndc+AgrvoxA4DChVm6
         Jkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698704437; x=1699309237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwrn6ID3BUu3z/5xyPAOjQ/FmaKW4prpre5IoiNlsn4=;
        b=EdGAM+eYWDXhgHfNV6coMQTqtd0OhHuuBw5vMZwrfWgFWiaKSF8V94NUDV7RQMfI4L
         H2lws7tnhzsRmlVEzVBqUdGhmL440zNnoS4Llz/7cPXTqBPKbREDqeWUTVlpRG4nhUFo
         h+x2Xpsi+2px/aKr2JKefkflcrEHYgDqYfdgDTwstnFF5jH97NkbjgTlBrTHaQUrwciH
         +C44X7F4o1vdojnztd8ao1rhGSxQEvShSLsMs889l92L7+LXZtcb9M5UqO5AvWgTFXR+
         a3IWUwPjmWCC1+fg7+w6y046PGspFrV6rt0X50Ef2AfdYJvxessI7gxrAyo3vyIuDvC6
         DubA==
X-Gm-Message-State: AOJu0YzvwGLY1a1x2DJ+1P14Nm0K9l6Uoy1T7y67VhRf+volGKbpeaWZ
        OloyDxTAz3p51iENzXtOkJc=
X-Google-Smtp-Source: AGHT+IHZWxgoXdrg/49jUHRAq9s4wHGmOIz4d8hUMx0Bc1YX+IJhAR0zZbX+DiJ33HPu8dI0JCo3VQ==
X-Received: by 2002:a05:600c:468e:b0:409:78e:1c42 with SMTP id p14-20020a05600c468e00b00409078e1c42mr9592992wmo.22.1698704437359;
        Mon, 30 Oct 2023 15:20:37 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id f7-20020a1c6a07000000b00401b242e2e6sm391576wmc.47.2023.10.30.15.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 15:20:37 -0700 (PDT)
Date:   Tue, 31 Oct 2023 00:20:35 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231030222035.oqos7v7sdq5u6mti@skbuf>
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
 <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 10:50:31PM +0100, Linus Walleij wrote:
> > you said that what increments is Dot1dTpPortInDiscards
> No this was a coincidence, we can rule this out.

I see commit 86dd9868b878 ("net: dsa: tag_rtl4_a: Support also egress tags")
also mentions: "Qingfang came up with the solution: we need to pad the
ethernet frame to 60 bytes using eth_skb_pad(), then the switch will
happily accept frames with custom tags.". So the __skb_put_padto() was
something very empirical in the first place.

Since it's all problematic, would you mind removing the __skb_put_padto()
altogether from rtl4a_tag_xmit(), and let me know what is the output for
the following sweep through packet sizes? I truly wonder if it's just
for small and large packets that we see packet drops, or if it's something
repetitive throughout the range as well.

for size in $(seq 0 1476); do if ping 10.0.0.56 -s $size -W 1 -c 1 -q >/dev/null; then echo "$((size + 42)): OK"; else echo "$((size + 42)): NOK"; fi; done
