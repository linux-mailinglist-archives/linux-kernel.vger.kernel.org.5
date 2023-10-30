Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17317DBF41
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjJ3Rmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjJ3Rmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:42:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D889C;
        Mon, 30 Oct 2023 10:42:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c603e235d1so768003366b.3;
        Mon, 30 Oct 2023 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698687748; x=1699292548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PwnToCFMv6zfDaKkoAmulmAJ1db08wlAKIPqHbZ9cVw=;
        b=DLL9x7FyTgsCgDkIb2jpIgVxIgZ9PzdV2GpE6jhOzczb3iTZEsQs+WeuMNJl9dZ3MO
         +0hDjDs5Gq7ueRuagBJSTJLWvrYyijgPCw7YuSE7xzwnYTH7p0kZzL9l0OVxR3fko8Hs
         aasiioa98bz00rBzQKF1ab1tIt1K76Q+dVXAU5y3yG2sIOR9PrWmq1mQ1zQV+fVMulRc
         I136rQfcVvgylObiaLOCMJqwkictEPaC9pgDBLBCug48WUJJQKEpf+w3iMmZo2DeQnh0
         4wD6TWY8fJCCM9V76hVWhkqnI4gOg5gjOdJdG1n/Eu5cHpg78pmE3Naa/CSnaNL4BmAK
         LGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698687748; x=1699292548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwnToCFMv6zfDaKkoAmulmAJ1db08wlAKIPqHbZ9cVw=;
        b=YhT6NB/u8nxK2resjCFPQpgMCLT1fymfJJtJTSUy+Zxt62YiJ0eQndyN8M0ktEjwoW
         X9f4Akk1lEEcb5aaEpOoBEGbzdcrrjAlKbOtjJHWXgxzAWjN3Vpd3xoiMiVWyWKnGWxR
         NKdUTZlfuiskXyjgH2SxwHBtsX4Ggmq+GAAxCm5Z5trY6QfDWyCGU6cKFYUnVVzHt4BW
         mHPV0Q0B6yAfAY0A1Z6hLxvYgqctUBmKB3vGwnAJSPcVpVXtLiMLG88KmvckfL5A+lqh
         Y4T3P65veyHdsfFw/jUrdrxrnXZrm9fiN9W4+ANRfW8FoOxgg+4McVOKmfbB1o/WYepY
         t3xA==
X-Gm-Message-State: AOJu0YxNQpxMmFlggDgGE1XnA1JPQ4RMAYMOm6sbQtnqcupWakq54gGN
        QuUN+nPYCaldlCurLmCH+sU=
X-Google-Smtp-Source: AGHT+IG+3qeNcNha9SOaNtlWC1v1vmcEQ+7Wn7CSpYpOQEdJyEcwtOcqP109+3jZINc7ygAXW1kplQ==
X-Received: by 2002:a17:906:fd8c:b0:9c7:5a01:ffea with SMTP id xa12-20020a170906fd8c00b009c75a01ffeamr10252264ejb.30.1698687748105;
        Mon, 30 Oct 2023 10:42:28 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id hb26-20020a170906b89a00b009ae3e6c342asm6363586ejb.111.2023.10.30.10.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 10:42:27 -0700 (PDT)
Date:   Mon, 30 Oct 2023 19:42:25 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Ante Knezic <ante.knezic@helmholz.de>, conor+dt@kernel.org,
        o.rempel@pengutronix.de
Cc:     UNGLinuxDriver@microchip.com, andrew@lunn.ch, davem@davemloft.net,
        devicetree@vger.kernel.org, edumazet@google.com,
        f.fainelli@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        woojung.huh@microchip.com
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Message-ID: <20231030174225.hqhc3afbayi7dmos@skbuf>
References: <20231024142426.GE3803936@pengutronix.de>
 <20231027063743.28747-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027063743.28747-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 08:37:43AM +0200, Ante Knezic wrote:
> On Tue, 24 Oct 2023 16:24:26 +0200, Oleksij Rampel wrote:
> 
> > > That is correct, I guess its a matter of nomenclature, but how do you 
> > > "tell" the switch whether it has REFCLKI routed externally or not if not by 
> > > setting the 0xC6 bit 3? Is there another way to achieve this?
> > 
> > I do not see any other way to "tell" it. The only thing to change in you
> > patches is a different way to tell it to the kernel.
> > Instead of introducing a new devicetree property, you need to reuse
> > phy-mode property.
> 
> > ...
> 
> > Since phy-mode for RMII was never set correctly, it will most probably
> > break every single devicetree using KSZ switches. It is the price of fixing
> > things :/
> 
> To Vladimir Oltean: What are your thoughts on this?
> 

Sorry for the delayed response.

It's complicated. In the Google-searchable RMII spec, the REF_CLK is an
input from the perspective of the PHY, and an input or output from the
perspective of the MAC.

Additionally, some RMII PHYs like NXP TJA1110 provide "extensions" to
the RMII spec, where the PHY itself can provide the REF_CLK based on an
internal 25 MHz crystal (see "nxp,rmii-refclk-in").

My understanding is that some other PHYs, like KSZ8061RNB, go even
further and make the REF_CLK be always an output from the PHY's
perspective (this is not configurable).

It is noteworthy that on Wikipedia, it says directly that REF_CLK can
also be driven from the PHY to the MAC, which itself represents an
extension to what the spec says.

Additionally, some MACs like the NXP SJA1105 switch ports are not as
flexible as the standard would suggest. In RMII MAC mode, this switch
always wants to drive the REF_CLK pin itself. And in RMII PHY
(self-called REV-MII) mode, the SJA1105 always wants the REF_CLK to be
driven externally (from the PHY or external oscillator). So, for example
the SJA1105 in RMII MAC mode cannot be connected to the KSZ8061RNB, as
both would attempt to drive the REF_CLK signal.

In addition to all of that, the MAC/PHY roles are not just about the
direction of the REF_CLK, but also about the /J/ /K/ codewords that are
placed by the PHY in the inter packet gap on RXD[1:0]. A MAC doesn't do
this, and if it did, the PHY wouldn't expect it, and AFAIK, would
blindly propagate those code words onto the BASE-T wire, which is
undesirable.

So, my opinion is that although what Oleksij would like to see is
admirable, I don't think that the REF_CLK direction is a matter of RMII
MAC vs PHY role, and thus, we wouldn't need to change "rmii" to "rev-rmii"
and cause breakage everywhere. It's just that - a matter of REF_CLK
direction. It's true, though, that this is a generic problem and that
the generic bindings for RMII that we currently have are under-specified.
We could try to devise an extended RMII binding which makes it clear for
both the MAC and the PHY who is responsible to drive this signal. You
are not attempting that, you are just coming up with yet another
vendor-specific MAC property which solves a generic problem. I can't say
I am completely opposed to that, either, which is why I haven't really
spoken out against it. The PHY maintainers would also have to weigh in,
and not all of them are CCed here.

Now as to Conor's previous question about describing the REF_CLK as a
CCF clock, which is a bit related, honestly I haven't really analyzed
the merits of doing that. We know from the RMII standard that has a
known expected frequency of 50 MHz, it's just a matter of who provides
it.

Just one small thing to note is that I have heard of RMII PHYs which,
when REF_CLK is an input from their perspective, don't even have their
registers accessible until that REF_CLK is turned on. This may be
problematic, because the attached MAC driver may also own the MDIO bus
on which said PHY is located, and it practically needs to turn on the
RMII REF_CLK before the PHY on the MDIO bus could even be probed.
Currently, IIUC, the way in which that works is that RMII MAC drivers
are simply coded up to do just that, and I guess that worked so far.
With CCF, I guess you would describe this by making the MAC be a
"clocks" provider for the PHY. But it could also be the other way
around, and in that case, the MAC would be the parent of the PHY, but
it would also depend on a component that the PHY provides. I hope
fw_devlink doesn't mind reverse dependencies like that...

I am afraid that creating a CCF style binding for REF_CLK will be an
enormous hammer for a very small nail and will see very limited adoption
to other drivers, but I might as well be wrong about it. Compatibility
between RMII MACs and PHYs which may or may not be CCF-ready might also
be a concern.
