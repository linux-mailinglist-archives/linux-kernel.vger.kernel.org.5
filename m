Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33047B50CB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbjJBLCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjJBLCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:02:52 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED00B3;
        Mon,  2 Oct 2023 04:02:49 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57b5ef5b947so9438118eaf.0;
        Mon, 02 Oct 2023 04:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696244569; x=1696849369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/u6dVjYrpGoHCKxgEpS5jFCOFbQ6uuPOGckyjrLF34=;
        b=HjXeyHWL0qlTdKEaFfaOp5iovSvGexCdiiftc6pvOD3u2r5LQ4biNKFizY3WIGFFIW
         negstdWln8s3DaYVK46Oc+LbDIEBAV0bNXC9DeekI7GmiwgWnqxw0o68N5Dc8zM3iZ0l
         Haa9hAvwLMJLr6kImw3T8O9O2WqeS2s3m9NTqgt1QXKtqnvu8xPFTo+pecaYmD6FhD5j
         qhUDJfATyc0UAwVwUft4XyLQc/YifgTOj54fPa7SeLleGdIm4xIwBYXJ0xOtvjYx2G0I
         OMmLgqEIViTdJQSI8fsEh6rb0a2mx7YRmzv6mAHWC3bicAsFiRRM/6d1mg0F4yajUflB
         zLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696244569; x=1696849369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/u6dVjYrpGoHCKxgEpS5jFCOFbQ6uuPOGckyjrLF34=;
        b=pMkylghnv+NMxvRJinPRaEBC2VY/gkJqxsFPOYCrTOW572ALXOLZdn7nGRFny/wXM3
         +tQhgjbNLlNBIPR6M+n1TUuaO2T+MHUCP5ckIku6tgUtvCUcYr0ks8NomwCgmHo/ZLnk
         Alc9WmeX3rM881+gdSqPmxF1Xfgq/QsuwGKy1CIcwxusG05UP33vpneWm/vpLSkNgFuH
         DNUdtazqQHX9iIKTsmGsuUeogFtCG//oSnc82ua4HSX0CNQKc6amvaiDEQt2XRsGVjBh
         HdaxXQGs52Qb7qgo3264VbO2CjHvn7ZIfwbepWrz1azwdn2QwcVlebLRcidTRPVqNAFO
         FrCg==
X-Gm-Message-State: AOJu0YzM9S/undWSoGTJ+nJScx6qJy6FydW7zaAvxEvJLw5DvaTzKh3C
        NQheK9hyBL8Rx51cpBEfho0s+76NUkuPiuMKpk0=
X-Google-Smtp-Source: AGHT+IFEPCYm8uwSzDqydf6AMYzArcE5BmUayh/Ttb35xvYlB9CHDxvyL30oBrLsD4aUWNhAHxDhIkCKR6X8SxqQQJ4=
X-Received: by 2002:a4a:d138:0:b0:57e:1618:e700 with SMTP id
 n24-20020a4ad138000000b0057e1618e700mr10363965oor.7.1696244568929; Mon, 02
 Oct 2023 04:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230929091206.13955-1-lhenriques@suse.de>
In-Reply-To: <20230929091206.13955-1-lhenriques@suse.de>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 2 Oct 2023 13:02:36 +0200
Message-ID: <CAOi1vP92B4E4Mt+8ALD00V-QhYBi9hLeLCR1jrBrKb493V6HXA@mail.gmail.com>
Subject: Re: [PATCH] ceph: remove unnecessary IS_ERR() check in ceph_fname_to_usr()
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:12=E2=80=AFAM Luis Henriques <lhenriques@suse.de=
> wrote:
>
> Before returning, function ceph_fname_to_usr() does a final IS_ERR() chec=
k
> in 'dir':
>
>         if ((dir !=3D fname->dir) && !IS_ERR(dir)) {...}
>
> This check is unnecessary because, if the 'dir' variable has changed to
> something other than 'fname->dir' (it's initial value), that error check =
has
> been performed already and, if there was indeed an error, it would have
> been returned immediately.
>
> Besides, this useless IS_ERR() is also confusing static analysis tools.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202309282202.xZxGdvS3-lkp@intel.com/
> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> ---
>  fs/ceph/crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> index e4d5cd56a80b..e19019209cf0 100644
> --- a/fs/ceph/crypto.c
> +++ b/fs/ceph/crypto.c
> @@ -462,7 +462,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname,=
 struct fscrypt_str *tname,
>  out:
>         fscrypt_fname_free_buffer(&_tname);
>  out_inode:
> -       if ((dir !=3D fname->dir) && !IS_ERR(dir)) {
> +       if (dir !=3D fname->dir) {
>                 if ((dir->i_state & I_NEW))
>                         discard_new_inode(dir);
>                 else

Applied.

Thanks,

                Ilya
