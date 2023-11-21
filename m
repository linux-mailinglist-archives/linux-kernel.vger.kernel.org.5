Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB707F2A58
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjKUK2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjKUK2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:28:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A04BA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700562491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ME8mQZAJfu3KmV5hnIpgicdED11+YLGNGZQG/TCbQu4=;
        b=dKnQzpWmF7YIzUft8mjpn8raS+FyETjkOS75OsOzZiNyOM/P0mWy0dEjexJJUSDmWtaQSF
        aRmZ9ucLctEBkRNL9qRYhQbmDHzgbTGYWjjm0m1A6nEqgfA/v/X4PblIR8u6R79sHW2/XM
        WqQNkV+yR2vaRQXdOzLDG82Uv2t3BOQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-jClnGcRLNUCIiz5xh0UteQ-1; Tue, 21 Nov 2023 05:28:09 -0500
X-MC-Unique: jClnGcRLNUCIiz5xh0UteQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9fe081ac4b8so18747966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700562488; x=1701167288;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ME8mQZAJfu3KmV5hnIpgicdED11+YLGNGZQG/TCbQu4=;
        b=HmOvjljxdeIBiTTDq2eh1PmVL7lZdBaY7ww9lnJIymKi8t1A0XWlAQiDDALxjoR5ny
         J3vSZVMk5iabzfbYtfKlYMFkUO6Ufpc90soJylzYyu0RPMi4wCwXs/tZJIxXnVTPLpYk
         Sa3WZHPHRGunvsrrxYFHfUrveVriQzj1R3aY2pYX7N8yYg0bVuOPo9ngMpbeBFAS6ICm
         BnMU5CCJLLgWnDAfOxURIWbI859m18DEwN0jnQVodluV4MMTHo0kH8hgTAIQq4Q8ih5c
         BKpu7Pm2pdBr4ti0P0s0iKH2z9cToj9Syz8+vewn2WgY4lfVdrt6AOiZWXC1hLMPK4m0
         EWCg==
X-Gm-Message-State: AOJu0Yz6ROI/aQxUWJulPRRtIlp/r20Al746Iiln3CHDHqZCwB4JvB+p
        49DRZ0fiotBcoV2EEdmtmGPsNefmen2Grx+vrtmJzFh6otC/hL8uzMI7Ud+DDBnrlaRU8B7FYIa
        eb3H1mQo3PIP1LRanrL2jckrm
X-Received: by 2002:a17:906:3089:b0:a01:ae7b:d19b with SMTP id 9-20020a170906308900b00a01ae7bd19bmr948654ejv.7.1700562488579;
        Tue, 21 Nov 2023 02:28:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfqBBKQjJPsSCckyoPS3IN1c9fpadiy3GzvbG30dUhcOb3QCInWZGvEZkzEtMTQhGKdrjcjQ==
X-Received: by 2002:a17:906:3089:b0:a01:ae7b:d19b with SMTP id 9-20020a170906308900b00a01ae7bd19bmr948641ejv.7.1700562488281;
        Tue, 21 Nov 2023 02:28:08 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-234-2.dyn.eolo.it. [146.241.234.2])
        by smtp.gmail.com with ESMTPSA id qu14-20020a170907110e00b009fc6e3ef4e4sm2993985ejb.42.2023.11.21.02.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 02:28:07 -0800 (PST)
Message-ID: <4fa33b0938031d7339dbc89a415864b6d041d0c3.camel@redhat.com>
Subject: Re: [PATCH 2/2] r8152: Add RTL8152_INACCESSIBLE checks to more loops
From:   Paolo Abeni <pabeni@redhat.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Grant Grundler <grundler@chromium.org>,
        Simon Horman <horms@kernel.org>,
        Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date:   Tue, 21 Nov 2023 11:28:06 +0100
In-Reply-To: <20231117130836.2.I79c8a6c8cafd89979af5407d77a6eda589833dca@changeid>
References: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
         <20231117130836.2.I79c8a6c8cafd89979af5407d77a6eda589833dca@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-17 at 13:08 -0800, Douglas Anderson wrote:
> Previous commits added checks for RTL8152_INACCESSIBLE in the loops in
> the driver. There are still a few more that keep tripping the driver
> up in error cases and make things take longer than they should. Add
> those in.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

I think this deserves a 'Fixes' tag. Please add it.

Additionally please insert the target tree in the subj prefix when re-
postin (in this case 'net')

You can retain the already collected reviewed-by tags.

Thanks,

Paolo

