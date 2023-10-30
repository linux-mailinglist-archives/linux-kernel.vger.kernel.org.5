Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314C47DBC83
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjJ3PXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjJ3PXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:23:32 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA60CA9;
        Mon, 30 Oct 2023 08:23:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9d274222b5dso274021566b.3;
        Mon, 30 Oct 2023 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698679408; x=1699284208; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eNH80CZxnqUyHpVk9sm9AYdpPQYIATzHj8k0WS+FHSU=;
        b=N/V6oVYvBAJNH76k2/U90OBTjW7t1T/iI+SGR5mzdiLpF6DsBXAXlbYWxK5UZU0pDM
         i5pJAhvqZmXdccJVIsRIRVfdNEN6N3mQoRjeKcBc2rJVDp0ZRKCrxlBWmwTBl+NAStXa
         iBHbP8Mpf6MlYDYTrgUjmeiUNe5NGxjnagar1TkBbQifN8h3sp7xjkyHVCnVUAPpqGE+
         jIgd74fdn3zgO6lFU1vFRk1/j7kfO9I2t6+TQWiudC9akKm7Teg1SDcKlYtO8j54FFs/
         5sVkP38+PZUNPhXUkmlVMKZEwZ6SmwbDoiju5euWQtd8JLd5ZrqgkGOqUBW/BE5LgKqt
         cS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698679408; x=1699284208;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eNH80CZxnqUyHpVk9sm9AYdpPQYIATzHj8k0WS+FHSU=;
        b=mFeAzA1/GFkd3bJvj3K0bJUx17agRXBQWA1VJCuQbiiDCJxg8wfVRSf+bMNkoqyTbk
         LA4NpcV2kZwDV1KbUZ7JOV85K1yqVgdCrGe/dNSJjoTvYuxUQ1dWBdoUtKn83JxigS/8
         tBW9COMD4OuGkOX99UkcuouGywbu7gHZRzasdyHNMhGM9XcpqUVYUR/0EuyXblxs3R7g
         4MNqB2vn5YpFh/VmxvINScdtSOSZ1PoWefJaaC75RU08+0DWMEpVacFf10kp7b7PPRYt
         6lWpnaL09+eehsWLa5Eb+Dkh5aiJ7+9URNnGNjbO0sJT/FbNaQ+KZ1FhkgSI8C4v5N/u
         h5IQ==
X-Gm-Message-State: AOJu0Yz0dCWsvzwqfyLW+SmREOLr0PuMDlWT1g3iWTpoekhkeQ+cX/3S
        +FnaeXvXUdeDaWYb/9e6NVE=
X-Google-Smtp-Source: AGHT+IGS5nNGthSZEJLEA8gIhHr1Cj5VgpSa4w8EbK/pMrU1iBuqRElaTqG0yRemfGMfWVOoSlM0bA==
X-Received: by 2002:a17:907:74b:b0:9bd:a738:2bfe with SMTP id xc11-20020a170907074b00b009bda7382bfemr8196716ejb.38.1698679408000;
        Mon, 30 Oct 2023 08:23:28 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906050b00b009a193a5acffsm6129522eja.121.2023.10.30.08.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 08:23:27 -0700 (PDT)
Date:   Mon, 30 Oct 2023 17:23:25 +0200
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
Message-ID: <20231030152325.qdpvv4nbczhal35c@skbuf>
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
 <CACRpkdYg8hattBC1esfh3WBNLZdMM5rLWhn4HTRLMfr2ubbzAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYg8hattBC1esfh3WBNLZdMM5rLWhn4HTRLMfr2ubbzAA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 03:37:24PM +0100, Linus Walleij wrote:
> On Mon, Oct 30, 2023 at 3:16 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> 
> > Could you please try to revert the effect of commit 339133f6c318 ("net:
> > dsa: tag_rtl4_a: Drop bit 9 from egress frames") by setting that bit in
> > the egress tag again? Who knows, maybe it is the bit which tells the
> > switch to bypass the forwarding process.
> 
> I have already tried that, it was one of the first things I tried,
> just looking over the git log and looking for usual suspects.
> 
> Sadly it has no effect whatsoever, the problem persists :(
> 
> > Or maybe there is a bit in a
> > different position which does this. You could try to fill in all bits in
> > unknown positions, check that there are no regressions with packet sizes
> > < 1496, and then see if that made any changes to packet sizes >= 1496.
> > If it did, try to see which bit made the difference.
> 
> Hehe now we're talking :D
> 
> I did something similar before, I think just switching a different bit
> every 10 packets or so and running a persistent ping until it succeeds
> or not.
> 
> I'll see what I can come up with.
> 
> Yours,
> Linus Walleij

And the drop reason in ethtool -S also stays unchanged despite all the
extra bits set in the tag? It still behaves as if the packet goes
through the forwarding path?
