Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4565C78396D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 07:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjHVFky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 01:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjHVFkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:40:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3152C130;
        Mon, 21 Aug 2023 22:40:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB24F61F5D;
        Tue, 22 Aug 2023 05:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1668C433C7;
        Tue, 22 Aug 2023 05:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692682849;
        bh=B0RTMXdNrXo+jpL+zYehIvYeTpfEwW/DXoX6NawYtmg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=DxxYZEEdc991o8aCPJuW8sE5QsbAvcS0SiA1SU3ofh4lwXy5m6oEgNDdb/1lODM+E
         DMqqg5adLjnYraZwDq2MKoarPSW9gQZuDDTQFwL/gsBszENsiDHJ3OwuwfAgQZCuhd
         H2Ajme4xW62Y/pr9c8Pe2kthuzB5ag92L9uhOW9O0/D2f1NArFGjOx3EHf5p8m/EWN
         t1VzMrxTRQtYt/ZokST7e7XMgUbjYDbuaJG9Q4oh6t61zBmC+77MY1rXp9HB96c+LB
         2RwJBh6iAnfA4yez1/uZxbqtiWq/7reZgtuHmFpOoo3KiFnaTAog4tWumToN0vCrqs
         ydClNHo6cQjnw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Sergey Korolev <korolev.sergey@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: kernel warns about voluntary context switch within RCU
 critical section in rtw88_usb
References: <CA+QjRnJ+YMdOM0OzwG+Pz8-mTPo5nZVioCjbz1xY0jVSGXBk7w@mail.gmail.com>
        <bfaa8714467a4954a045475e062f78b1@realtek.com>
Date:   Tue, 22 Aug 2023 08:41:45 +0300
In-Reply-To: <bfaa8714467a4954a045475e062f78b1@realtek.com> (Ping-Ke Shih's
        message of "Tue, 22 Aug 2023 01:47:34 +0000")
Message-ID: <87pm3fws4m.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Sergey Korolev <korolev.sergey@gmail.com>=20
> Sent: Monday, August 21, 2023 10:28 PM
> To: Ping-Ke Shih <pkshih@realtek.com>; Kalle Valo <kvalo@kernel.org>; lin=
ux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: PROBLEM: kernel warns about voluntary context switch within RCU =
critical section in rtw88_usb
>>=20
>> Please note I use an unmodified driver from the upstream=C2=A028c11c2949=
4f1b34e39641eead9c60a8bd26170d
>> ("wifi: rtw88: fix not entering PS mode after AP stops") build for 6.2 k=
ernel (Ubuntu 23.04).
>
> I feel Martin has been addressed this problem during development of SDIO =
and USB
> by 8a1e2fd8e2da ("wifi: rtw88: Move register access from rtw_bf_assoc() o=
utside the RCU")
> Please take a look if this patch is existing in your source.=20

Commit 8a1e2fd8e2da was merged to v6.3-rc1 so v6.2 won't have it.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
