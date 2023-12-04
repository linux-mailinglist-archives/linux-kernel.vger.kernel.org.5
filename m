Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD34803E01
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjLDTDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjLDTDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:03:04 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA4AF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:03:10 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4649299d0a0so394762137.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701716589; x=1702321389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yaO/BTFuN+hdaZ3dr+nTdBWWXl4w8z8dbFIh9uyCDo=;
        b=HVT1ki/kjA/4juD3BVgoIAF1cV99rD2Z5PPysMldRbBX2ol7iK2RzDVBrGIN1eCeO+
         hjBF90sfWU96h1MHkSV1nvm99BwcN+rB+PkTNpKtxK3ejEWi0ZjH/zyE2w4pMi1DarQ9
         T1Z4CtAS7dMqpv/FqAb3SHfg8MZlac6VKI2vrAPN4+BWThEhsP6azo1HZpmgZEA2nVXe
         Zge7DRbLN/fBc8T7oZ2rUl/oUeZaFww5JWsm8PcKietdEl2V4QjgFD0CP1WX2mrWS5jt
         N1kVhfYTOsqpqW2uoGZNoUKWqvK3w2fmDz4f1HniAMsEGjOuiZctiDGD1cof8Hcn/x7y
         mBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716589; x=1702321389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yaO/BTFuN+hdaZ3dr+nTdBWWXl4w8z8dbFIh9uyCDo=;
        b=atAnvkYcq63pWOJTUOi8RJDVb+I4B8F5Qg+It8g0NfEGS7MzjsKrPxnitckdnqjziN
         yjqZKl/NzZTmz8jmgmtZfDpTPpUWzsLTZ3A25NdT1u9SLgTGob29qvE5HmMQa5dvtq9j
         h42HYFPxqc1pitwmNVL1fNKiJJtmEeOzKt7kvoV/mfHOy/1a7USEiSn6sfhtHR31RIyh
         06aFdoIpPdp3qtia27nNDTP+WYzP5eQ5TxJq5hhjyfUw1VecmjP57mwehCJnDIhRgWlb
         Qpg++DCLkv8eOrWVjWbPOAEw8ecI44RgvasR17+TpEINpcY+ZHgiCbefIMJ56GS35dBc
         CVZA==
X-Gm-Message-State: AOJu0YwjOirJAwvIx9h6bCLX4FG4PaLLxs2c1YjSzTR8xy3z7uHX95NL
        emZWagth97//Kaw9HWndPdvBdIeEfq3ymEOOhcQ=
X-Google-Smtp-Source: AGHT+IHx2fJpWDvTw2VKMw7ZWa7AZ6Rjp2hXyHx6dU/sGjxgbNBWELhAzuwxM3yL2y0OEcXGx6baE8F20seioBN2j/Q=
X-Received: by 2002:a05:6122:1797:b0:4b2:c554:fbb1 with SMTP id
 o23-20020a056122179700b004b2c554fbb1mr2666171vkf.19.1701716589352; Mon, 04
 Dec 2023 11:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20231204180428.925779-1-jaegeuk@kernel.org> <20231204180428.925779-2-jaegeuk@kernel.org>
In-Reply-To: <20231204180428.925779-2-jaegeuk@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 4 Dec 2023 11:02:58 -0800
Message-ID: <CACOAw_xbm4MinoOeimooCEketA=5oKWr46e-gU-ZtAG_rpWDAg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/4] f2fs: fix write pointers on zoned device
 after roll forward
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM

On Mon, Dec 4, 2023 at 10:06=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> 1. do roll forward recovery
> 2. update current segments pointers
> 3. fix the entire zones' write pointers
> 4. do checkpoint
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/recovery.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 16415c770b45..d0f24ccbd1ac 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -917,6 +917,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi,=
 bool check_only)
>         if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &=
&
>                         f2fs_sb_has_blkzoned(sbi)) {
>                 err =3D f2fs_fix_curseg_write_pointer(sbi);
> +               if (!err)
> +                       err =3D f2fs_check_write_pointer(sbi);
>                 ret =3D err;
>         }
>
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
