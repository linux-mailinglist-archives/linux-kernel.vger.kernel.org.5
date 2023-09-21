Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F217AA21B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjIUVMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjIUVLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038DC9D464
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695318969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJuzqw6y7Ip39zFY8UF3H/ph0aENOEUx7vxRau7h7Js=;
        b=dhCJbHTZOe2fkQ+81EEmeOr794mj5DVYMH6yecZcn/pSi6fGXgGKf4Lnb/edO8ojR4g8kP
        Nd2zoPStGn76cGKInqAkUt+5do349oBi2KKS08xhmGYMNAZs0iVwxN+pY9qcfYrgZoQkC/
        zxm1xmhEzkjvaTJgQusKqZRCbL3NPmk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-hGOjfZZbOEaBPn3sdUNEmA-1; Thu, 21 Sep 2023 10:40:48 -0400
X-MC-Unique: hGOjfZZbOEaBPn3sdUNEmA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-53347126bf0so113850a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 07:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695307247; x=1695912047;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJuzqw6y7Ip39zFY8UF3H/ph0aENOEUx7vxRau7h7Js=;
        b=SphPO4+w9Qa1NVSo1I35WCV65B/uRgfVoA8YiTDma1k3KvUFUFXiVdBNRAvmJWc6YY
         KbZwUB/UvjR3QgBbG/o3kIv8xzwMFQDhwS7KN+yZ07Y+W4g8N/Hu9KLXzvWLcRMnwAMU
         qlW8eMoVAyfU0hKxABRJPQW17CdEOuStjN1dOd+AExtQUXJc6qIrhSInrLiUq/5U9Oe0
         B0dFp+QWlpXrYIO7z899jRhWVoHdm0JmkNp/VFh2ej/RjrBnf6PaxexRWVGClU3YO28b
         1yvDMyzNwrOKYiN5UwFuTYQqOZO6sMXFQGvdcimurkzbw1BsOj2OK/7DX7kWQ+QnMQMg
         qKBw==
X-Gm-Message-State: AOJu0YyRIi51Jf/c4GEly+98tXgfSVb7DowRMdqiijybctXsCi0K0qec
        gUh7/JPWIkifhFI9IvxC4NipNptQINd0FYs6w+aQGCGM8Lta13Ek1sASnHoZUKqxQjGQtK6YJOK
        ciFH15PUFB/eQED9RplofR9my
X-Received: by 2002:a17:906:d3:b0:99c:5711:3187 with SMTP id 19-20020a17090600d300b0099c57113187mr4432970eji.6.1695307247352;
        Thu, 21 Sep 2023 07:40:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUXkWRy8pyVz5Er6anCQu7FYs2J46jfxMTML3x7ct4qBYd5KH3WxyrVl/hSXMaku8sKa2ejQ==
X-Received: by 2002:a17:906:d3:b0:99c:5711:3187 with SMTP id 19-20020a17090600d300b0099c57113187mr4432954eji.6.1695307247050;
        Thu, 21 Sep 2023 07:40:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id lt12-20020a170906fa8c00b009a219ecbaf1sm1163364ejb.85.2023.09.21.07.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:40:46 -0700 (PDT)
Message-ID: <5615a39b3402e7499fd531c928845e102fba6f1c.camel@redhat.com>
Subject: Re: [net-next PATCH] net: sfp: add quirk for Fiberstone
 GPON-ONU-34-20BI
From:   Paolo Abeni <pabeni@redhat.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 21 Sep 2023 16:40:45 +0200
In-Reply-To: <ZQmkv9o329m98CUG@shell.armlinux.org.uk>
References: <20230919124720.8210-1-ansuelsmth@gmail.com>
         <ZQmkv9o329m98CUG@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel,

On Tue, 2023-09-19 at 14:40 +0100, Russell King (Oracle) wrote:
> On Tue, Sep 19, 2023 at 02:47:20PM +0200, Christian Marangi wrote:
> > Fiberstone GPON-ONU-34-20B can operate at 2500base-X, but report 1.2GBd
> > NRZ in their EEPROM.
> >=20
> > The module also require the ignore tx fault fixup similar to Huawei MA5=
671A
> > as it gets disabled on error messages with serial redirection enabled.
>=20
> I'll send you shortly a different approach for the "ignore tx fault"
> thing that I'd like you to test please.

Said patch is not blocking this one, am I correct?

Thanks,

Paolo

