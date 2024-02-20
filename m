Return-Path: <linux-kernel+bounces-72575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB0585B568
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE621C2268F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02125D495;
	Tue, 20 Feb 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WIErpTU5";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mC3lvYRb"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476B85CDCE;
	Tue, 20 Feb 2024 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418239; cv=pass; b=CAfKvOfmvcyfS03GSZWxtOF7GgKe/lnxv3mHEgWCXO3cyswSgW/yH+WO6KXnGhmbo6CY90x7HCf4f6LazrffhsJIbLcug85a0vC7unTV2YFfW336D4tv68xVYeM4BQTNKedV0ULSS3uwb3TUdZkBAijX30h4dFqoAjBE+I3KhCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418239; c=relaxed/simple;
	bh=WNkuwlB0kpCublS0QCB7/FlGjFYntxM/1P8ltw9FE7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlX+zrWp6GMiXGAK+75O3LMLFlXTWl2lAmwRprAr8/JGnVi65oTNBNDjRVFws0dJAQVU7CC1yVKtefDAEmIvY7X2dP+sBbpHQmb/uIYRoJgWXKVe/bW9mFXmLycxFvD0689haDz1qYwMPP8FP2WU2qaTeerUDRZTg7R5j8ja0vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WIErpTU5; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mC3lvYRb; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1708418227; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LMKmlxenTj/mMJMCGr9WHLEEkV+mxN/lAeAtuxCmO5m9192oZgLHbU/Eq9WboJNlrt
    hN9c1Nc3OimQvTaUZpggjevquoB+/jdKN5x97AdSHwBM8RCgWnvdOXi0faBedX1lA2F7
    kfdj2cEjZxYUld6u+34u+JlGVJbXUF4c8Nya4AQ2jZ5OeAcZrDL7x0ccfaTgAS6kjlk7
    EtiDbxzFOYBgkVIXNGOe9FelsteM62fN/tjFWU7iUf0kUwBMOeyoyEhz2ICxpJoDdMtr
    fSDq387V0uMv56cScHGU5NqfJ6Nx2dMvzHC89RB6W1pWOCWDQpumla/pyltOPnbAIvdk
    bMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1708418227;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=w1+N5nmOtWnLi94k+DWY1OzXI8lNh2fy9ZiJf7+zafE=;
    b=fZ48uNEltlyqFLk1b7JzRT1cmuN9qLvxRM9eIJRzPIufVRrnKNzizPgDMkCpf6R+kM
    YcO+0S8pk7cvH4F1DYqO24N7X6gJ5GYWU76rkEhbjLTePM2fcO3+sxqVV1kap3ZwoNMK
    NAETU1huAlVgpRNtqjzwPMMsvPs5v8e/klEcFc8R+oZppwHFtIMBVFBry2FmmH91facH
    7t3zcjhpJEBodr3KVKxekQZbIPfcBopYoyMnOFpNjqS/H5HhXCMgdfEc6LQZvl5NWv/i
    pWlOzYf032M3qhdiq/y2VgxZWh4zELapiR6QcvnYvfe48VKhEND+1W+QV1yiLBRFz2HD
    X97Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1708418227;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=w1+N5nmOtWnLi94k+DWY1OzXI8lNh2fy9ZiJf7+zafE=;
    b=WIErpTU5iAFrUm1K22oAC9AX8DUdqIbxJRtqcIRBL2LBo2g/TI1zgOOWAZY/dRBMf1
    42DaoxDTRrhvIZX0FNP+LXoy1BCQFOtEkBdxOEMNLewLX1/yksUuHgCcYIHa6pESeIUm
    TOm9kIguJpEI2pWk6UnYkpzXf4S6X85BvKZciUbz9dGJkhKEgL4nUZrANNZXTJNfx2Xs
    wrjl+JMI2VcvLPlC7dhavLM4nTirYhDuSFSZRJmQz40zyE94BM2HkptoWggAS2Z/Jkb9
    e+NgtIKsU94oTM5deTIn09l7tdw83dgUZ0WMzoQaIWVXs/uMMkvGB2o00tI4LSZvVTnl
    +X+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1708418227;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=w1+N5nmOtWnLi94k+DWY1OzXI8lNh2fy9ZiJf7+zafE=;
    b=mC3lvYRbUErbjlzaGOifUO836b2jR58LKy4+KJ6NFJiheVqc2gZAAEHfbVQkdX7BJk
    E/CP/h+VhcLCMIvUr1Bg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0UTaMxFv7GMj7FQ8pbj4LdEENz42GQ=="
Received: from [IPV6:2a00:6020:4a8e:5010:df30:9f26:ac40:e6a6]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01K8b691B
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 20 Feb 2024 09:37:06 +0100 (CET)
Message-ID: <785e60d5-a73e-4f5f-ada0-a9d1891e9c75@hartkopp.net>
Date: Tue, 20 Feb 2024 09:37:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: raw: raw_getsockopt(): reduce scope of err
To: Eric Dumazet <edumazet@google.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240220-raw-setsockopt-v1-1-7d34cb1377fc@pengutronix.de>
 <CANn89iL7N-1zvBBLoz0qhCApVJRF1LKu=jSyC0yz-wHa3JLGNg@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CANn89iL7N-1zvBBLoz0qhCApVJRF1LKu=jSyC0yz-wHa3JLGNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024-02-20 09:25, Eric Dumazet wrote:
> On Tue, Feb 20, 2024 at 9:16 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>
>> Reduce the scope of the variable "err" to the individual cases. This
>> is to avoid the mistake of setting "err" in the mistaken belief that
>> it will be evaluated later.
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>   net/can/raw.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index 897ffc17d850..2bb3eab98af0 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
>> @@ -756,7 +756,6 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>>          struct raw_sock *ro = raw_sk(sk);
>>          int len;
>>          void *val;
>> -       int err = 0;
>>
>>          if (level != SOL_CAN_RAW)
>>                  return -EINVAL;
>> @@ -766,7 +765,9 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>>                  return -EINVAL;
>>
>>          switch (optname) {
>> -       case CAN_RAW_FILTER:
>> +       case CAN_RAW_FILTER: {
>> +               int err = 0;
>> +
>>                  lock_sock(sk);
>>                  if (ro->count > 0) {
>>                          int fsize = ro->count * sizeof(struct can_filter);
>> @@ -791,7 +792,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>>                  if (!err)
>>                          err = put_user(len, optlen);
>>                  return err;
>> -
>> +       }
>>          case CAN_RAW_ERR_FILTER:
>>                  if (len > sizeof(can_err_mask_t))
>>                          len = sizeof(can_err_mask_t);
>> @@ -822,7 +823,9 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>>                  val = &ro->xl_frames;
>>                  break;
>>
>> -       case CAN_RAW_XL_VCID_OPTS:
>> +       case CAN_RAW_XL_VCID_OPTS: {
>> +               int err = 0;
>> +
>>                  /* user space buffer to small for VCID opts? */
>>                  if (len < sizeof(ro->raw_vcid_opts)) {
>>                          /* return -ERANGE and needed space in optlen */
>> @@ -839,6 +842,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>>                          err = put_user(len, optlen);
>>                  return err;
>>
>> +       }
>>          case CAN_RAW_JOIN_FILTERS:
>>                  if (len > sizeof(int))
>>                          len = sizeof(int);
>>
>> ---
>> base-commit: c8fba5d6df5e476aa791db4f1f014dad2bb5e904
>> change-id: 20240220-raw-setsockopt-f6e173cdbbbb
> 
> What is the target tree ?
> 
> In net-next tree, syzbot complained about a bug added in
> 
> commit c83c22ec1493c0b7cc77327bedbd387e295872b6
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> Date:   Mon Feb 12 22:35:50 2024 +0100
> 
>      can: canxl: add virtual CAN network identifier support
> 
> Patch to fix the issue has not been sent yet ?

The patch with the fix has been sent yesterday and Marc applied it to 
his linux-can-next tree for a pull request to net-next.

https://lore.kernel.org/linux-can/20240220-mobility-thigh-8ddfb02bfab9-mkl@pengutronix.de/T/#t

Best regards,
Oliver

> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index cb8e6f788af84ac65830399baac6d1cf3d093e08..897ffc17d850670003e5cf3402477e8fc201f61e
> 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -835,7 +835,9 @@ static int raw_getsockopt(struct socket *sock, int
> level, int optname,
>                          if (copy_to_user(optval, &ro->raw_vcid_opts, len))
>                                  err = -EFAULT;
>                  }
> -               break;
> +               if (!err)
> +                       err = put_user(len, optlen);
> +               return err;
> 
>          case CAN_RAW_JOIN_FILTERS:
>                  if (len > sizeof(int))
> 

