Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1387CC92B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJQQyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjJQQyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:54:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E382FE;
        Tue, 17 Oct 2023 09:54:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3C1C433C8;
        Tue, 17 Oct 2023 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697561656;
        bh=a13SyTChAbXtSyLKA3Qytu86LSlP+mbJIA1znGRGbho=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=G9e4tcB0/TgPX8wK2gT0kCasihjQQyColUwNmjQr8L2RQxJfX2hI/rK0ggsKkJkun
         Whj6/zbd8VxTKfc/xfAcqBz8Pfyzf4JyNEJP3ZnGIT5hDYV6UgB6UpdrOv0B4eshkF
         Ebl12GnCuBAb60Sn3yZNAts68NGmf5jAVmhJSO1VNur7j0CkmQYIqRbI4V93fOdxem
         D7JXAx8S2PpTLX79eQOM7ZaEcgDAHzcHbxf0v1/tauwoDZcEtzejxoF/q9H2vw6aiF
         pZqvCpyrBULgIsBkJyiKyRYRtVxn8AFA2HSUryb9agMeu44RZGCNDrnJdMUfVbPD7S
         25PdFFhTsB4UQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Franky Lin <franky.lin@broadcom.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] brcmfmac: replace deprecated strncpy
References: <20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v2-1-6c7567e1d3b8@google.com>
        <CA+8PC_cZbchz-i0Wfhr1rE5M-xqUVdQZce94TowU=yqOynDBKg@mail.gmail.com>
Date:   Tue, 17 Oct 2023 19:54:11 +0300
In-Reply-To: <CA+8PC_cZbchz-i0Wfhr1rE5M-xqUVdQZce94TowU=yqOynDBKg@mail.gmail.com>
        (Franky Lin's message of "Tue, 17 Oct 2023 09:48:51 -0700")
Message-ID: <875y352nrg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Franky Lin <franky.lin@broadcom.com> writes:

>  Hi Justin,
>
> On Mon, Oct 16, 2023 at 3:14=E2=80=AFPM Justin Stitt <justinstitt@google.=
com> wrote:
>>
>> strncpy() is deprecated for use on NUL-terminated destination strings
>> [1] and as such we should prefer more robust and less ambiguous string
>> interfaces.
>>
>> This patch replaces multiple strncpy uses. For easier reading, I'll list
>> each destination buffer and mention whether it requires either
>> NUL-termination or NUL-padding.
>
> Kudos to the detailed analysis of each instance. One thing I can think
> of to make this better is to split it into smaller patches so if any
> regression is observed, only the specific code causing it needs to be
> reverted. Maybe instance 2, 3, 4 can be handled in one patch since
> they are touching the country code in one file. The other instances
> each can be an individual patch.
>
> The "brcmfmac" in the title is not accurate. The change touches both
> brcmfmac and brcmsmac. So "brcm80211" would be more appropriate.

Please also add "wifi:" to the title, see the wiki link below for more
info.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
