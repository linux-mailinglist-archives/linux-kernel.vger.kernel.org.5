Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04F977FC15
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353662AbjHQQ1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352797AbjHQQ1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9236C35A8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692289574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EZk7pCD0HPe+ABrfYsTMs6MpHKEmTin7ICiAaY/ju7w=;
        b=SB2y1C6uaovcXcaqVqD0zl73lOfEcek+3YwgOsloL7AAJau90iiwfZNMMiM+atu8XYi4tH
        on5Ahel4J1FqtBLUEahe2KCbTPnvY8V5S+zr0im144n9gFGxvF6MW+AV/qv1E6/7q8E+xv
        B8ISeH/n1c1S/8/khwKmfqZstLRWH/Y=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-CS4FbSzwOmmFJW8n0k7UAg-1; Thu, 17 Aug 2023 12:26:13 -0400
X-MC-Unique: CS4FbSzwOmmFJW8n0k7UAg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-589f986ab8aso10797b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692289572; x=1692894372;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZk7pCD0HPe+ABrfYsTMs6MpHKEmTin7ICiAaY/ju7w=;
        b=JBqxmQXhyiJPC6bMeBUsk8/UrD8Cw4O/YPt2nQ9lFT9ewClZuA++sgHxFe4DWYS+S8
         y0Uq2Fo/GKLIMTkqC3Kmj2QywIRKs2J0XHRn9NqRRi4XjEEafc0usKg0Ajq9gVBEX6z+
         wm9FA4B54Sj5vYZgD4nkGhU5XlwT2iN/f4HvYFTjnSE122rVF0KzIPyjs6lua2s/2nMW
         vgaq5QJZ1SVB0bodNhMvvRtd4BMG8OBLtpPnFLW7DCTXvPPzsMTEtzK88voxKVrxWd0/
         JhcsVweOFAfhaN5eLBdnpPCnEpAgsxxwiuzfMxRykIaEfX+ipAQOyAD1HKQ8WJys3eQg
         8VXA==
X-Gm-Message-State: AOJu0YzD2xem7b2Px41+E7LC/xAz/sa4XfI71fgTW32NGFwUUEDufE2r
        cZOn1Pu5FmeNReaGuMtIXB6m06OLTdhanDGRFR0tUaED+bXSvTK91C+rpi3YuYfKGZhCSwvDl+y
        roXYQG4t4fVig0jNCqI4wE2xM
X-Received: by 2002:a81:9289:0:b0:581:7958:5bda with SMTP id j131-20020a819289000000b0058179585bdamr4117559ywg.1.1692289572679;
        Thu, 17 Aug 2023 09:26:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFDMsUg7Qvc0ShK/beubOLSc6c6/DQghAOnIqHeSrnHVzvTsNVwwDg01IycrQ1PQJjVGdmfg==
X-Received: by 2002:a81:9289:0:b0:581:7958:5bda with SMTP id j131-20020a819289000000b0058179585bdamr4117535ywg.1.1692289572426;
        Thu, 17 Aug 2023 09:26:12 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id y8-20020a0dd608000000b00589e84acafasm1079736ywd.48.2023.08.17.09.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 09:26:11 -0700 (PDT)
Date:   Thu, 17 Aug 2023 12:26:10 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     andersson@kernel.org, linus.walleij@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom-pmic-gpio: silence -EPROBE_DEFER message
 on probe
Message-ID: <ZN5KIlI+RDu92jsi@brian-x1>
References: <20230817145941.1091418-1-bmasney@redhat.com>
 <a3431eaf-053a-4e1c-b082-e87a3aaefbf3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3431eaf-053a-4e1c-b082-e87a3aaefbf3@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 05:01:19PM +0200, Konrad Dybcio wrote:
> On 17.08.2023 16:59, Brian Masney wrote:
> > The following message shows up one or more times when booting a Qualcomm
> > SA8775 Development board:
> > 
> >     qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: can't add gpio chip
> > 
> > Convert this over to use dev_err_probe() to silence this message.
> > 
> > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > ---
> That looks odd, why would it ever defer?
> 
> SPMI should be up by the time it gets a chance to probe.

You replied within the same minute of me posting that patch, which is
the fastest review I've had to date on an upstream kernel list. Before
we continue, please verify:

              [ ] I am not a robot

:)

So SPMI is up and probes normally the first time, and is up by time this
driver probes. I think the probe deferral is happening somewhere in
pinctrl, however I am not sure exactly where. I added some tracers to
the kernel command line and here's some relevant log messages:

    device: 'c440000.spmi:pmic@2:gpio@8800': device_add
    bus: 'platform': add device c440000.spmi:pmic@2:gpio@8800
    PM: Adding info for platform:c440000.spmi:pmic@2:gpio@8800
    bus: 'platform': __driver_probe_device: matched device c440000.spmi:pmic@2:gpio@8800 with driver qcom-spmi-gpio
    bus: 'platform': really_probe: probing driver qcom-spmi-gpio with device c440000.spmi:pmic@2:gpio@8800
    qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: no pinctrl handle
    qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: try to register 12 pins ...
    pinctrl core: registered pin 0 (gpio1) on c440000.spmi:pmic@2:gpio@8800
    pinctrl core: registered pin 1 (gpio2) on c440000.spmi:pmic@2:gpio@8800
    pinctrl core: registered pin 2 (gpio3) on c440000.spmi:pmic@2:gpio@8800
    pinctrl core: registered pin 3 (gpio4) on c440000.spmi:pmic@2:gpio@8800
    pinctrl core: registered pin 4 (gpio5) on c440000.spmi:pmic@2:gpio@8800
    pinctrl core: registered pin 5 (gpio6) on c440000.spmi:pmic@2:gpio@8800
    pinctrl core: registered pin 6 (gpio7) on c440000.spmi:pmic@2:gpio@8800
    pinctrl core: registered pin 7 (gpio8) on c440000.spmi:pmic@2:gpio@8800
    pinctrl core: registered pin 8 (gpio9) on c440000.spmi:pmic@2:gpio@8800
    pinctrl core: registered pin 9 (gpio10) on c440000.spmi:pmic@2:gpio@8800
    pinctrl core: registered pin 10 (gpio11) on c440000.spmi:pmic@2:gpio@8800
    pinctrl core: registered pin 11 (gpio12) on c440000.spmi:pmic@2:gpio@8800
    qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: no hogs found
    qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: error -EPROBE_DEFER: can't add gpio chip
    qcom-spmi-gpio c440000.spmi:pmic@2:gpio@8800: Driver qcom-spmi-gpio requests probe deferral
    platform c440000.spmi:pmic@2:gpio@8800: Added to deferred list

The second time it probes the device is successfully added.

Brian

