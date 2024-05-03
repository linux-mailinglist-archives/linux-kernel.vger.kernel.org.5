Return-Path: <linux-kernel+bounces-167940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A53A58BB160
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B924284FF5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBA9157E7A;
	Fri,  3 May 2024 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="h/XuJOfP"
Received: from sonic309-21.consmr.mail.ne1.yahoo.com (sonic309-21.consmr.mail.ne1.yahoo.com [66.163.184.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4AD157E69
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755655; cv=none; b=cJanXD234YdG1V92j9nm0qyl/e+PBBU8fej6YiSqqGvoLviChya+eChTzOk6pkWICeaxCjWe9Z8DNDsSeYtKKsF3sHUqpDv16HY8z2XcuYE374g/Dz77+/bk0ZyoqTAz9xmkusR246L7fBLvfR9ax0aj9/5CbOPk1+RO9eQf9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755655; c=relaxed/simple;
	bh=OpuBHTwhnfArlf2PsQ6g2wnS/DKkhtNrSqNbd0Cd8cY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=gXl+yf7mKywFkKcjif2mNkSCuQJOI49IyjapsvEVBqtJpYUrcrdAUVJA+lErWMCBNrpAVXp4B7BgGeAzvvGOXOkWyDgUaCuEtlJXwRQAw6Ms5Yb8nxSTX6lbBHykiLlSkcfEW3ohBAziO6Xy8qWlt7fZtACnTL83piWp1fDO9lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=h/XuJOfP; arc=none smtp.client-ip=66.163.184.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1714755652; bh=OpuBHTwhnfArlf2PsQ6g2wnS/DKkhtNrSqNbd0Cd8cY=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=h/XuJOfP4qeWJeJUfu9XI2dvEgzygtrC4CQkQr52hHqL+u5d0EZKbP2COHmnzEf/JrOcrHLPnb3WKJ8WKv7KYu67zkNNbxwbMhHZAkfXWXsOApW31dy8X39SKCTp7/aUnyM+SkluOIU1tReyUEiYIPp83FqHP+7BHFnLBWjlh7AoF8bnulEyF2VKqInpLbYgAM31rUm5IpaFK88Qmb+Xm/jPTZSkNBXqogko/W5N6AuBT0PRrH9mWkBQHSH0zAL5AE/2EeQWUS9lvCZNTpQK4mFb07RYgGwHL6cgc0kaJnLvM27Za+5x+X2Sv32SB53OshVlWVpage6SsD2T8PfCkg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1714755652; bh=0roRuDy5zj7FoPPBMx4pCT5IazAPisE/VYX4kM5YcgX=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=HN77FixkNFiIjdzTyPTCglXSTr73Q8fEfEGAbRTRYzo88nHJQOH9TKg/z4eTL0k0WD3sJsnOenB0QLHcY3ttLXCvw5wHfeI/hEKOSz98IlZbow//bKIscA0ODOnBLYW7eCiszIyiiWVu1vNVc1EMtvLrIcrYubuC5EFu/EhKyDv33/ckazLlFjDjQDgtt0Sxn7EnoGSATXzRlDKsVelY2A0ReFSC0ZWlkpF7JDYCnJ1vd9+pXt+22hCXMVFdFpOKcMfRuVBGaPqG2WDmGV4vzfhJ9e+dNQqL6bCLtudkdhmYIYD21igDk1HidLAYyb5l75+V0av8B0W9KVv1kkDMlQ==
X-YMail-OSG: u7CikhkVM1mEMBJgRhgeFfykAxEVELBK2D8SuCjgxXEHVfhg2Mh1jCun.7euP4n
 YuKTaefJTFGNeHA6y0GKN8r5o3pt6uZ4L7fJsdR9huBW4xI._HbSxGmtwL7Q.r.q2HNLUhrxNcqJ
 iQk0clfL4rJB7emk22t.djOQDkv.3brzpvxYm7mD76etPxjsHtjznB4tUyLYzXFO.6IDvqV7cuVU
 s7YU8V1I5QXnD2RY954jhO_zWBG1FHHEhnmc2lafLzGClMxUD1sSeuRmEUnPzd9UJb1XvnNuPzoR
 HDhGIP5Qbmk9vsiiNBfzez4x4g8KFg3M.G5Uk5n2WX7L_k6B9_ZGCVtrDh348xQOjY1Y_1Cd81b4
 noQswoJiZsryvGYbOrdRyqJAQrn1NxglYFDVVQ8ihsj3JFsAg8idJ57wbS4lW1zJR0z2hwX0D5L8
 Ah9_5UWH5vGNxPLESZLBXSsL8X91UjsCxu6TnFw7uhzNds6_ofPqhWISo6wokWtoHo4s5i_Dd1g1
 pgusS5pHJ1PX8KPBpv1fMxnUGbma5Mq06lphYU_SSXY4i5qCBUK37DNnJIV5AgXDEbpreAvPY5KN
 vR8Tb6Q2yF6axmhLYw2qwsfnAUr0vA_Jzc2pUUzAeDxF6I0UPkjLA7a7yiaDIczakKX6dwdSJ.mG
 58OM_lkjw52d71AdkfrDJUX2MksGHq1K63WSXuFurdzA3S18AlusvV.5PFProfYCIRztn0BDISD2
 Qa0GpFEiFwlzby4x0fgGxV8dJZ7Xq5ugd4xBCV.6.A2dnjy26PjzG0jwSLH9GPjFaJGaVk9uUasX
 Ix6sSXmG_K_jm3KYote_PDn6JLIa0hbq_HNpR__3cjgTP1plr_6Akyd1GFihjkHF_mscqbk6S76Q
 jpIhhLUmyHcsZ.NWMfj678JphFYyxPaOOxLXXAMfL_zhiEjNUJvyW4VexTTgNZ3xy4unuIoacAoJ
 i65ljO1IAGxShzOLanEqKFAMguiVBBN84wbYDBpr0kbG1lU32E1cGTIczqgW2w82DRV0zMHp7_sk
 RkIuj5k_JzxlnN5zNfGNQ27h3I4gVCCP9gOc5wekqRwLV8ifLYRb0bPkd8tD7JmD2LZ4W42b5344
 HsLeoU48IJJDVr0YJZVirumWrxsKvF2I3o7_KXaVyliAP25U_deLjmT.BBE1UONAftNh2kNMOZhG
 ak5IKdiwLyK6_12ip8oazaBJj_0W2q_gqrvjiq4bKG6iI._HycRHunW22uHeF9wvQrk5tc_APutn
 ySnbWQ9ziXxvaBWtboypHwNZUDPR.1KsQgcqJSY2RL3r9XfaUo845YNVfdFuXJRnWkIvdttDKler
 fyJKbvSmeSCJKhNzvxBHRQYh5n.3NYvEikv_TsZJacJhbUnWXZUvXasP37MGyoQ7GLT5da687ovE
 MPDnTVH5iJuFgVqg.nx3oyRUA1nTBGBfvFZYSiKFVAvWHa4stTt3NH3SSaTDdTBWfIGRsYGhkvLA
 dGy3Z7XijAEEDsjVV7IcaVpLVWIbJ5jIIBJ13eYMxWVJ5f4A4lIZrv_SZBpvByB1sfv.DS7gSonq
 1VNOutIuK8hijTa9otiRaFsP5_Q0XVFGUteywvHokJuiKc9VgRr3JHFzTPQ4VicD_5wUtc5IFJ1G
 Whv.16lmZ496l.ekC09_B7nK3cP4JcBG1bvLevBfXuZGDgqGnk69NAcG7XfInLZXd.siTtH_j2Hu
 Um8ryul1Tv18C0USqxm8iwpFTlN8Nnzyfmboy0o0wiQplgRXpa.HUUaRAp_Q1evqftIW2KXhIQd.
 PgvidYsIBtF.XIaFWMsLdcMg1GvBlnp_6PRqwXVoLM2PAqh5VqVkQQTOfaBeMPEn8jtbd6qNLLqP
 0LUJpjXA1La1EIPftMu6oPuaNY5s2vCt4KwXJcivqOm8eJpB7YSB6SjubeIV9IqXdILqqdTIJ5I1
 loXhSfvkPvTocCDcdoz7FvbKaejGqeAjQjG8RIM0v82Pdtw0DCF.8aCwGPn7CiVmUwVA3AB8L30S
 N_n9FCd6TcDBPoK5HwRSX..z0kdfVosVSs6SS2qsrOs3jY06vlXP0PhNz2EG_YmgI7YvRoqKxbY7
 PKcwpvJsXvM7YBuftOiseBjk3I_KzychmFW.f.Ls34I5eM8XzWMW0LfYeBAwTIprJKhvL6V_Vrms
 tgESrkIU7v9UtaRwWh7DKRHDJUDHgqExo6lBS0mqHPrUKy.hVNgkJlB2PDa_Qv4JSP3Rf1VmTgvH
 Fcv96CSp4tjyCAXFkI47vWUo4VCWan1qd7NG.JaBVJ1kVaf_Z0uiLr9CVPVJD6A.o_UxUDqo-
X-Sonic-MF: <ashokemailat@yahoo.com>
X-Sonic-ID: b20f7dc0-ce88-4f67-8215-c25d657d58b6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 3 May 2024 17:00:52 +0000
Date: Fri, 3 May 2024 16:20:24 +0000 (UTC)
From: Ashok Kumar <ashokemailat@yahoo.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, 
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"outreachy@lists.linux.dev" <outreachy@lists.linux.dev>
Message-ID: <1389558595.6771301.1714753224419@mail.yahoo.com>
In-Reply-To: <c8d24241-1763-f7b7-4491-2e5aa3ea3be@inria.fr>
References: <ZjRDUO6/M+RDCcQJ.ref@c> <ZjRDUO6/M+RDCcQJ@c> <c8d24241-1763-f7b7-4491-2e5aa3ea3be@inria.fr>
Subject: Re: [PATCH] staging: fb_tinylcd Alignment to open parenthesis
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22256 YMailNorrin


On Thursday, May 2, 2024 at 11:54:58 PM PDT, Julia Lawall <julia.lawall@inr=
ia.fr> wrote:=20







On Thu, 2 May 2024, Ashok Kumar wrote:

> Corrected coding style CHECK: Alignment should match open parenthesis

Ashok, I think the code is nicer as is, because it has all the constant
numbers lined up.

julia

Thanks for the update I will ignore this change.=C2=A0

Is there a list of exceptions to the checkpatch information that we can ign=
ore in general.


>
> Signed-off-by: Ashok Kumar <ashokemailat@yahoo.com>
> ---
>=C2=A0 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
>=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/f=
b_tinylcd.c
> index 9469248f2c50..60cda57bcb33 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>=C2=A0 =C2=A0=C2=A0=C2=A0 write_reg(par, 0xE5, 0x00);
>=C2=A0 =C2=A0=C2=A0=C2=A0 write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
>=C2=A0 =C2=A0=C2=A0=C2=A0 write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x0=
0, 0x00,
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00, 0x35, 0=
x33, 0x00, 0x00, 0x00);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 0x00, 0x35, 0x33, 0x00, 0x0=
0, 0x00);
>=C2=A0 =C2=A0=C2=A0=C2=A0 write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
>=C2=A0 =C2=A0=C2=A0=C2=A0 write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
>=C2=A0 =C2=A0=C2=A0=C2=A0 udelay(250);
> --
> 2.34.1
>
>
>

