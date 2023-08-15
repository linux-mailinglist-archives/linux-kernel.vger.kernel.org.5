Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E01F77D167
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbjHORxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238995AbjHORx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:53:29 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A8E1BDD;
        Tue, 15 Aug 2023 10:53:28 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9a2033978so85716521fa.0;
        Tue, 15 Aug 2023 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692122007; x=1692726807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6izKbIOTgb/qz23oAv6uR2Dz0fJpUIMeg8RsCpk5YY=;
        b=NZhdilkX6qy2u8vPeM3IEdmjoKeYXzSKq3yVNByqsAykdaePQ1XnSjCfKd62EQnQv9
         ybsw49p8VxUsI9yINGMpXqHicmHBSZy+LxTVUNAq1GiRxSaCL5jM6/CRDXiVSjT7T3pC
         z4NMD3MWW+X/72L2RwAev85q1IiQl+ru2zZh1+RKOLDYiP3CNxmA8oMtqWXy9pZri/PD
         XVVbik0G38mexR0p4sJgTjzNJ6H/9TsNGLXNk8f7UZa85hZ4EMUBZr8g1zkV0WUyqU7Y
         ViKa7v64QknHqVcGUYtWDFwWWohz9Dw76o6UdvBLHvMvbXyPgZt6T95QM9/qV3I5jihe
         hLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692122007; x=1692726807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6izKbIOTgb/qz23oAv6uR2Dz0fJpUIMeg8RsCpk5YY=;
        b=NTaJWPcitIxLDex0f6irwhkE1uSwp7jMn451+OnVFce10wHVqbpAWWACCu8KFynhz/
         vH85+x+ybTb2Qzu7uTPMe1fFq+4ta/1YSK45DC6TSRUIFN5HKuZxpD7/c0a/B86hNS65
         csESB48owxXlbRe8BoLtozbEPQlcxiuarrKagw0AOY5hLdsidiTbYsDJ1/HpQiqCL5KP
         l+OaZ53Ga3L43VF+KhDtHTvBZoii4oqaNjQnPfF7KB/45Sbq/5Hx2ZMk7GvofzljKBH9
         S0yLbtR4crrbJR0vuFocFzHHP+QTmIH3dOu0MJh1AxP+UwV164L+4Y+IDUT8eaF/G04F
         o5jA==
X-Gm-Message-State: AOJu0Yw+oJ+xo9ssYh2TBuOrXfjCcm7Mnquu8N8V83J/RMtmMrp5j58G
        g4wS6nRPgt6EFdQnO2XGNuc1EEhR2ePCURfH7ro=
X-Google-Smtp-Source: AGHT+IH7c5x5jsgYP8WMrhIP4iE8RWzsBQAYP6BKmOTFVj6nJZTMweOqmB9pyAjZ1eIhRhKutpsDvfzE/Fn0/zreUKE=
X-Received: by 2002:a2e:9cd8:0:b0:2b9:e53f:e201 with SMTP id
 g24-20020a2e9cd8000000b002b9e53fe201mr9372665ljj.31.1692122006479; Tue, 15
 Aug 2023 10:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <869240bf-7f91-4131-b56a-7ac2585dee4e@buaa.edu.cn>
In-Reply-To: <869240bf-7f91-4131-b56a-7ac2585dee4e@buaa.edu.cn>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Aug 2023 10:53:14 -0700
Message-ID: <CABBYNZ+_LFZ4uNHRKqb39_J-vDKj2qkmiTGikP8uMi3v4YtLsg@mail.gmail.com>
Subject: Re: [BUG]Bluetooth: HCI_Connection_Complete: possible semantic bug
 when HCI_Connection_Complete is discarded
To:     Xin-Yu Liu <LXYbhu@buaa.edu.cn>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        baijiaju1990@gmail.com, sy2239101@buaa.edu.cn,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 15, 2023 at 6:56=E2=80=AFAM Xin-Yu Liu <LXYbhu@buaa.edu.cn> wro=
te:
>
> Hello,
>
> Our fuzzing tool finds a possible semantic bug in the Bluetooth system in=
 Linux 6.2:
>
> According to the core specification v5.4, when connecting to a remote dev=
ice, the Host sends an HCI_Create_Connection command to the Controller, and=
 upon successful execution of this command, the Host receives an HCI_Connec=
tion_Complete event=EF=BC=9A
>
>
>
> In our testing, if the HCI_Connection_Complete event is discarded and not=
 received by the Host, it will result in a connection failure. Subsequently=
, when attempting to reconnect to the same device, the Host does not send a=
n HCI_Create_Connection command, but instead sends a Create Connection Canc=
el command and receives the corresponding HCI_Command_Complete event. Howev=
er, the connection still fails. Performing the same steps after some time y=
ields the same result=EF=BC=9A
>
>
>
> We are inclined to consider the possibility of occasional HCI event loss,=
 and it is reasonable to expect Bluetooth to incorporate some solution for =
managing packet loss or implementing a timeout mechanism. However, based on=
 our testing observations, the loss of an HCI_Connection_Complete event dur=
ing a connection attempt appears to lead to subsequent connection failures,=
 which could potentially be seen as less than optimal. There could be corre=
sponding remedies to address this issue; for instance, implementing a timeo=
ut mechanism might be a more favorable option.

There is already a command timeout in place, as for packet loss that
should be handled by the underline driver as it depends on how
reliable the transport is. If you are saying the connection
cancel/abort logic does prevent new connection with the same peer that
would be a bug, that said if the attempts are concurrent, within the
command timeout, then the same hci_conn would be used as there should
be only 1 ACL at time for a given peer.

> We are not sure whether this is a semantic bug or implementation feature =
in the Linux kernel. Any feedback would be appreciated, thanks!
>
> Best wishes,
> Xinyu Liu



--=20
Luiz Augusto von Dentz
