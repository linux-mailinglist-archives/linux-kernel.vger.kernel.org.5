Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA2B755D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjGQHod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjGQHoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B1010C0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689579812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQVhAdPhMy3kA8WlEpRTBlp68XeaAscXbJ2l6phyeAs=;
        b=SYr3r2Nj4FBGnSRa6g05KqleWMjMhOm3Hv9ycPKHQZ/YGCopTbyqF/6e/SxTHdSMb9n3T9
        1eIPSu+utg1poV+lFXTpKy1tvyRWqPK8Bj0LiOuZsqUwqk4PFxE0JU4dFvS2bFOxmkap7C
        xe5z4lhxNfAKvRphmGF+NSBjllkpEgM=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-Rm9MVVwYPH-LFRm0VjdIPw-1; Mon, 17 Jul 2023 03:43:31 -0400
X-MC-Unique: Rm9MVVwYPH-LFRm0VjdIPw-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-565d30b4311so5547482eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689579810; x=1692171810;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQVhAdPhMy3kA8WlEpRTBlp68XeaAscXbJ2l6phyeAs=;
        b=IzjuU/u4p7I745y7z+OMnsQn9CEng4HuDJ/4S2uN9dBPS4p9YBG476mIoT7j8wURFg
         KDOkxGqxu9c1SrFKHk5jnVP7tbz/eI7PbdwVPIl1CfQN97ur+3G6noNa2q65GK3T0DLB
         VaGg+u8CM7UQbdBm+33ORn5wJ5mMu+fa8mqImaTcKIR+NnuS7Ar0u5Jh9RPOvQ2QSJsO
         D/w8ePNQV3eVe57qupvGm9zXr5vlqCkGk/B8guQtpUhF614TEGwsiXEKknkc8wpPck3t
         NXWR4bqDmg8IyKKgxtM0hMsWoW9eA+9EMvNnSUILNs6Bd4gFuLa/VXBGDsg/tdfMghvd
         9yfQ==
X-Gm-Message-State: ABy/qLZf5tsRA3gD8PO9avLaj5YsRC19KnquZ0a477wNHazRaCoAJV+U
        9Q4xAeGd4eyecJyxZTZKXo1qWT6/TMNAuuPWD/2ihEop7sbBKNW89bNN2HvhfjjyvAEH5yyBdKy
        DkxOLGLwtn63VcTYSJ2fx6ZXz
X-Received: by 2002:a05:6358:90f:b0:134:c37f:4b63 with SMTP id r15-20020a056358090f00b00134c37f4b63mr10463397rwi.2.1689579810585;
        Mon, 17 Jul 2023 00:43:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFK36ibipM0G2rzToLTfIecoh81m8Px1hLNcEbl1T9WmTowhFWmHY6w0sOGmKuUZwVeblBkeQ==
X-Received: by 2002:a05:6358:90f:b0:134:c37f:4b63 with SMTP id r15-20020a056358090f00b00134c37f4b63mr10463390rwi.2.1689579810286;
        Mon, 17 Jul 2023 00:43:30 -0700 (PDT)
Received: from smtpclient.apple ([203.212.242.27])
        by smtp.gmail.com with ESMTPSA id t2-20020a17090a950200b00263f33eef41sm4377184pjo.37.2023.07.17.00.43.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2023 00:43:29 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] vmbus_testing: fix wrong python syntax for integer value
 comparison
From:   Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230705134408.6302-1-anisinha@redhat.com>
Date:   Mon, 17 Jul 2023 13:13:25 +0530
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <761F02E9-7A80-486B-8CB4-B5E067D7F587@redhat.com>
References: <20230705134408.6302-1-anisinha@redhat.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 05-Jul-2023, at 7:14 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
> It is incorrect in python to compare integer values using the "is" =
keyword.
> The "is" keyword in python is used to compare references to two =
objects,
> not their values. Newer version of python3 (version 3.8) throws a =
warning
> when such incorrect comparison is made. For value comparison, "=3D=3D" =
should
> be used.
>=20
> Fix this in the code and suppress the following warning:
>=20
> /usr/sbin/vmbus_testing:167: SyntaxWarning: "is" with a literal. Did =
you mean "=3D=3D"?

Ping =E2=80=A6

>=20
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
> tools/hv/vmbus_testing | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/hv/vmbus_testing b/tools/hv/vmbus_testing
> index e7212903dd1d..4467979d8f69 100755
> --- a/tools/hv/vmbus_testing
> +++ b/tools/hv/vmbus_testing
> @@ -164,7 +164,7 @@ def recursive_file_lookup(path, file_map):
> def get_all_devices_test_status(file_map):
>=20
>         for device in file_map:
> -                if (get_test_state(locate_state(device, file_map)) is =
1):
> +                if (get_test_state(locate_state(device, file_map)) =3D=3D=
 1):
>                         print("Testing =3D ON for: {}"
>                               .format(device.split("/")[5]))
>                 else:
> @@ -203,7 +203,7 @@ def write_test_files(path, value):
> def set_test_state(state_path, state_value, quiet):
>=20
>         write_test_files(state_path, state_value)
> -        if (get_test_state(state_path) is 1):
> +        if (get_test_state(state_path) =3D=3D 1):
>                 if (not quiet):
>                         print("Testing =3D ON for device: {}"
>                               .format(state_path.split("/")[5]))
> --=20
> 2.39.1
>=20

