Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEC27A5E88
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjISJs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjISJs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695CBE8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695116854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PkAmog8kPURPdwC6/7i2WeWfLhkTcmYXq3osNRaDjMc=;
        b=ZsSB11gmx5I8OFO92EODAuAUKvvaZuTWrQX0V46pgw+2fEa0NfBTbUGQOcpGc8s6iGOn+D
        zsn2YOG0INZICqGLhSiPLwzT2K4ckmXCRmyvNrXZdtnfmlPiOeRIYVxNZc5VrALb7IcAyG
        JuFkcPyO21nsocMZhxV2GHL+08txtXI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-iEe3u7oWMguXbpuCztmU8w-1; Tue, 19 Sep 2023 05:47:33 -0400
X-MC-Unique: iEe3u7oWMguXbpuCztmU8w-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-530a085c62dso604858a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695116852; x=1695721652;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkAmog8kPURPdwC6/7i2WeWfLhkTcmYXq3osNRaDjMc=;
        b=O50IUaHBD2nFTvM5wLXYLvuDa9F9TpTNOohcbMGLTzJwXVYUOqG/HBD2MmEgLFzuU/
         9OPanlLSbUJP1yRRMHB60kyhEdk04JeauHCfZKl3XEYOl8ueBdjr0XX+Gj/qBw110dWY
         U5nvF8HLHogx+3ajEXd536p8ZIG3rZI/YzzQyVxODcv4PhzIbZw7AtpdqQkK9eSH8Ssx
         RkAjwcyeHQMaPJh7F5mNSl1l/hdCUGkWl5z+86wgN5x2/dmojnGudb7zqn9NlJ7tlxE/
         CnFfzPT6FXeznCNsHPqzeAVc1quum4j3XV8GrFvoTjKPm5ya5zHReobhbBpbX+cgVc9H
         Y2Rg==
X-Gm-Message-State: AOJu0YxlGITLypPTMG/GRvektXNQLPht1RY0G1VSZfti1yx0dtEX4fXL
        mNRTzXvFCAfWbV6XmBvBmhQETwKHfj23ZzCFBGgcs1GwL2BoPIQfpKWpCZDkTAl0Mnn2Qcvusr1
        4G/fDeSIA0OlQc2+seZH/m6pK
X-Received: by 2002:a05:6402:1909:b0:52f:bedf:8ef1 with SMTP id e9-20020a056402190900b0052fbedf8ef1mr10972064edz.3.1695116852156;
        Tue, 19 Sep 2023 02:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdyvAkbPqoRHbFUkr3X4vyY71M+jXmRtg9LjpdFeCk47m2ui+Zr9bOc1plBfUmhqktSYoOhA==
X-Received: by 2002:a05:6402:1909:b0:52f:bedf:8ef1 with SMTP id e9-20020a056402190900b0052fbedf8ef1mr10972040edz.3.1695116851880;
        Tue, 19 Sep 2023 02:47:31 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-221.dyn.eolo.it. [146.241.241.221])
        by smtp.gmail.com with ESMTPSA id t13-20020aa7d70d000000b0052328d4268asm7013685edq.81.2023.09.19.02.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 02:47:31 -0700 (PDT)
Message-ID: <3f79b0d4b9409a223f03c0b36b3544ce1389a500.camel@redhat.com>
Subject: Re: [PATCH 4/4] net/onsemi: Add NCN26010 driver
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jay Monkman <jtm@lopingdog.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Arndt Schuebel <Arndt.Schuebel@onsemi.com>,
        Parthiban.Veerasooran@microchip.com
Date:   Tue, 19 Sep 2023 11:47:30 +0200
In-Reply-To: <ZQkNfAOYgsBIhBRW@lopingdog.com>
References: <ZQf1QwNzK5jjOWk9@lopingdog.com>
         <6e19020f-10ff-429b-8df3-cad5e5624e01@lunn.ch>
         <ZQkNfAOYgsBIhBRW@lopingdog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-18 at 21:54 -0500, Jay Monkman wrote:
> On Mon, Sep 18, 2023 at 06:00:37PM +0200, Andrew Lunn wrote:
> > Is this an OA TC6 device?  At a quick look it does appear to
> > be. Please make use of the framework Microchip is developing:
> >=20
> > https://lore.kernel.org/netdev/20230908142919.14849-4-Parthiban.Veeraso=
oran@microchip.com/T/
>=20
> Yes it is. I wasn't aware of Microchip's work. Thanks for pointing it out=
.

I guess this patch is going to change a lot in future revisions...

Please double check the code with checkpatch before the next
submission, there are a few things that could be improved.

Specifically, avoid c++ style comments, and avoid using multiple label
names to jump into the same location - selecting the label name as the
target action will make the code more clear.

Thanks,

Paolo

