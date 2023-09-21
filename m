Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C27A99B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjIUSRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjIUSRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A4E7E7CB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695318645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7gLU3+rfv3HHSp+DEvudAw0y1szA/aWbZkWDtyEikvk=;
        b=BmdLBp92AbesraJKxWOI5+H/820A4lB+1b1x8zs2XvUGvN0zea9QXWaWG6ymOhD4U5vcYs
        csmgy4I3oW4awRrFDu8NqlnDEIZt9gzIs7JCQoTpJI6qgqbQXxN8sMcxWijogbR2TiPfTo
        PPRADXtohV3MzQKIY/LUzxvobqH38Y4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-Xj1ewyqlPTaFsdRgSQSXgA-1; Thu, 21 Sep 2023 10:35:35 -0400
X-MC-Unique: Xj1ewyqlPTaFsdRgSQSXgA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2a7a6393ba6so2289111fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 07:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695306933; x=1695911733;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gLU3+rfv3HHSp+DEvudAw0y1szA/aWbZkWDtyEikvk=;
        b=jYdTSA3xPQ83bKAyAlhr7zSCbKkTuTk1bHKxJAf+UuyO0XpgkaBGZXdNB1+tOoU7I3
         gc1YyonvB7ZTlydZNrzGSHPrUss2e0BMMcG+WLW9GqVJW9SGypDtpXF0iL15iyS0ovOd
         2c/fEO9i9lES7TyY1qAoL7AlNT+0xlTPQeNkNrueOZj7qyRCHnhmbTJ/3OWyLL0iAmwK
         0Wd5JyuOlSiDUiILOts/OqYA6OG1Uci4DD6MCp3BwYFflxpc0kegcHT2CjVqjNE9YVJO
         syvkq09vLpe9ts4uv6BwZ4yNFj18nJRhNRpj1X7jKHzrr2FQJHr590+fhZEUsJsZERhh
         3s5g==
X-Gm-Message-State: AOJu0YygzpNjQ8Gxb1amG/tF60L9jAyNExgRPhqSNElVLG7gaulsXZme
        HiM1s/XUvm9cLi30saD/ZppW/wJ7mi9Z76Y9fEYvSX3O/3qnKTP/pJxCFD0uWLfwZiR2zS0JcG+
        SPvEfCDV4FoMmXaLYTdfAnCOiB27rxiIQQ7w=
X-Received: by 2002:a2e:a60a:0:b0:2bf:eafb:3442 with SMTP id v10-20020a2ea60a000000b002bfeafb3442mr4138861ljp.3.1695306933631;
        Thu, 21 Sep 2023 07:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuAp7m0hjif9+lpPxXN9OH1XssIg13XiXVjnldMBJ6IlMoqth3cyfJJFOhFSvkHo1V5fnjJQ==
X-Received: by 2002:a2e:a60a:0:b0:2bf:eafb:3442 with SMTP id v10-20020a2ea60a000000b002bfeafb3442mr4138856ljp.3.1695306933291;
        Thu, 21 Sep 2023 07:35:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id j8-20020a170906474800b0099297c99314sm1126843ejs.113.2023.09.21.07.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:35:32 -0700 (PDT)
Message-ID: <a15822902e9e751b982a07621d180e3fa00353d4.camel@redhat.com>
Subject: Re:  [GIT PULL] Networking for 6.6-rc3
From:   Paolo Abeni <pabeni@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 21 Sep 2023 16:35:31 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I noticed after sending the PR that since this morning I have email
delivery problems with lore: "Recipient server unavailable or busy."=20

That is likely something in between my corporate server and lore, as
messages form other sources are reaching there.

I'm wondering is if my PR reached somehow your inbox and/or if I have
to re-send it.

Thanks!

Paolo

