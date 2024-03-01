Return-Path: <linux-kernel+bounces-89033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA85786E9B5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7C71F254D1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435DC3BBCF;
	Fri,  1 Mar 2024 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wrh1aiWz"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DED3B789
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321871; cv=none; b=QBQYFCTC6QhJmvMzS+/zAaUTNa0J+5354RX3mH2WTxJ0v297aR4gpQD2s35GzelgTVz5SE1LOn0Qf8PgAOuLNMq1qKC7SJXazaaSHmNbMNw/3DBxtaS9tN+vDlwhUgroSYupdCmqr64lk+QGNkNNSvVifE9y93RYy9VxHPPpg9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321871; c=relaxed/simple;
	bh=jKrG6QS9qQWHcoFkHR26CKL4wC+kkLGosTa//iiHXm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqM1HExfjJbl7jcJqw8OcKal+qHXybib7fon6afFWexwRuwrUjHFhsZpggr2K5JaIfh8LdZiX36wXC+nUWKpsJswsaIKErOb9XVcuKGOku7nKg2cjE/mPrHBH2RAx2qrocFXDWbJPfJI9spUJQxCY1Jp9VQplpoBrJW1n0iLyU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wrh1aiWz; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6903ffc4bc6so9166806d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 11:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709321868; x=1709926668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGkeNRdG2FczCV6rPVYPMJDiNjYVnLlJt0xSA7ew594=;
        b=Wrh1aiWzy0flhM6unY8+oMzHUQ04G9/VlLWcsMviZ3NU5wt6562z/v/4A75Yn7VROV
         TVfp884V/7ulafkLTry+NCweIHozpM+9iwS6yT5gHj5A4/9TjfIWx/w89i+bxY2rXr7y
         ijEydEEXSHZ5Jzy2+qw+Akf2Roelz3R2Gu4Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321868; x=1709926668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGkeNRdG2FczCV6rPVYPMJDiNjYVnLlJt0xSA7ew594=;
        b=u5bNIi3zv0AE+nLp1wr8t8b3XfqoLLdi+J3z65tBSC1i7Buo2YOVc/0q3fkuEKP8bH
         sjt7BSIlR1rsn4hJUfEkQiHQpae51K1exPbWHj2pZcTZZXl7XpZHjP1AKgMUcW+tAo+J
         8rK9suDZvra70e3jNtbWVSWft8mixaPutXmMkkVH87XFtZbEjqzSx9lmldqAOuLmpvfw
         mqxvACMCtwGi2oyuXuUS7y6H5Q0y0TGay4ocPDBVrTqSCoaC5SxV/GiYD0OEFpWag6xI
         W+3rOWaYsTA2B842OHIpXA0oLUKNgbz0bJuzPHs5HY+Cem4PSY87d1wiyuvLQkWFv8Q5
         +iHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxDvVfYAc0ZH2N5q8XetUNWulqeDMzDaljXguKenhrwPol3D5jg5CN2TIwLj+XyO8QZgV51gZ6h9ONNSu6nJ1s2LtLk/Y+LXKLiole
X-Gm-Message-State: AOJu0Yw1bvGce8Q0RQ1HMmqT4POIcXHs83dPg996K1F9mzwTa5OC18Mw
	wGXa9LmVh3T5VPCMgrxdXy2d9uEhJlQ3v8gj8RLWLUFJ73AqQJzEBU8gIlD2I2F4Iu2GdVo35MP
	PsudBT42MFJJ/XsuF+f29rA65LPRoNiNVNf07
X-Google-Smtp-Source: AGHT+IHi1hjTt1ARy97BXMT6VU6Qb4Dz7SjLHKe0bYzv6iRPppZu6eRnfb1sb9m2IyWlA5swq9IJNVUtpDsf8IdzdwM=
X-Received: by 2002:a0c:fa8e:0:b0:68f:4645:8cad with SMTP id
 o14-20020a0cfa8e000000b0068f46458cadmr2723328qvn.57.1709321868606; Fri, 01
 Mar 2024 11:37:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229232625.3944115-1-jthies@google.com> <20240229232625.3944115-4-jthies@google.com>
In-Reply-To: <20240229232625.3944115-4-jthies@google.com>
From: Prashant Malani <pmalani@chromium.org>
Date: Fri, 1 Mar 2024 11:37:37 -0800
Message-ID: <CACeCKaeSdAwS5NJd0UtwZKvfvWMJmrJAg73e8SB+ToM5exOVUg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] usb: typec: ucsi: Register SOP/SOP' Discover
 Identity Responses
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	bleung@google.com, abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 3:28=E2=80=AFPM Jameson Thies <jthies@google.com> w=
rote:
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.=
c
> index 7c84687b5d1a3..4088422b33c74 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -646,6 +646,121 @@ static int ucsi_get_src_pdos(struct ucsi_connector =
*con)
>         return ret;
>  }
>
> +static int ucsi_read_identity(struct ucsi_connector *con, u8 recipient,
> +                             struct usb_pd_identity *id)
> +{
> +       struct ucsi *ucsi =3D con->ucsi;
> +       struct ucsi_pd_message_disc_id resp =3D {};
> +       u64 command;
> +       int ret;
> +
> +       if (ucsi->version < UCSI_VERSION_2_0) {
> +               /*
> +                * Before UCSI v2.0, MESSAGE_IN is 16 bytes which cannot =
fit
> +                * the 28 byte identity response including the VDM header=
.
> +                * First request the VDM header, ID Header VDO, Cert Stat=
 VDO
> +                * and Product VDO.
> +                */
> +               command =3D UCSI_COMMAND(UCSI_GET_PD_MESSAGE) |
> +                   UCSI_CONNECTOR_NUMBER(con->num);
> +               command |=3D UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
> +               command |=3D UCSI_GET_PD_MESSAGE_OFFSET(0);
> +               command |=3D UCSI_GET_PD_MESSAGE_BYTES(0x10);
> +               command |=3D UCSI_GET_PD_MESSAGE_TYPE(
> +                   UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
> +
> +               ret =3D ucsi_send_command(ucsi, command, &resp, 0x10);
> +               if (ret < 0) {
> +                       dev_err(ucsi->dev,
> +                               "UCSI_GET_PD_MESSAGE v1.2 failed first re=
quest (%d)\n",
> +                               ret);
> +                       return ret;
> +               }
> +
> +               /* Then request Product Type VDO1 through Product Type VD=
O3. */
> +               command =3D UCSI_COMMAND(UCSI_GET_PD_MESSAGE) |
> +                   UCSI_CONNECTOR_NUMBER(con->num);
> +               command |=3D UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
> +               command |=3D UCSI_GET_PD_MESSAGE_OFFSET(0x10);
> +               command |=3D UCSI_GET_PD_MESSAGE_BYTES(0xc);
> +               command |=3D UCSI_GET_PD_MESSAGE_TYPE(
> +                   UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
> +
> +               ret =3D ucsi_send_command(ucsi, command, &resp.vdo[0], 0x=
c);
> +               if (ret < 0) {
> +                       dev_err(ucsi->dev,
> +                               "UCSI_GET_PD_MESSAGE v1.2 failed second r=
equest (%d)\n",
> +                               ret);
> +                       return ret;
> +               }
> +       } else {
> +               /*
> +                * In UCSI v2.0 and after, MESSAGE_IN is large enough to =
request
> +                * the large enough to request the full Discover Identity
> +                * response at once.
> +                */
> +               command =3D UCSI_COMMAND(UCSI_GET_PD_MESSAGE) |
> +                   UCSI_CONNECTOR_NUMBER(con->num);
> +               command |=3D UCSI_GET_PD_MESSAGE_RECIPIENT(recipient);
> +               /* VDM Header + 6 VDOs (0x1c bytes) without an offset */
> +               command |=3D UCSI_GET_PD_MESSAGE_OFFSET(0);
> +               command |=3D UCSI_GET_PD_MESSAGE_BYTES(0x1c);
> +               command |=3D UCSI_GET_PD_MESSAGE_TYPE(
> +                   UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);
> +
> +               ret =3D ucsi_send_command(ucsi, command, &resp, sizeof(re=
sp));
> +               if (ret < 0) {
> +                       dev_err(ucsi->dev, "UCSI_GET_PD_MESSAGE failed (%=
d)\n",
> +                               ret);
> +                       return ret;
> +               }
> +       }
> +
> +       id->id_header =3D resp.id_header;
> +       id->cert_stat =3D resp.cert_stat;
> +       id->product =3D resp.product;
> +       id->vdo[0] =3D resp.vdo[0];
> +       id->vdo[1] =3D resp.vdo[1];
> +       id->vdo[2] =3D resp.vdo[2];
> +       return 0;
> +}

There is some repetition here, both with the "if" block and the
UCSI command itself. You can factor out the command setup code into a separ=
ate
function (it can take offset and size as arguments). Then, factor out
common parts in the "if" block. For example:

int ucsi_pd_message_get_identity(struct *ucsi, u8 offset, u8 size, u8 recip=
ient,
                                                              void *data) {
        u64 command =3D UCSI_COMMAND(UCSI_GET_PD_MESSAGE) |
UCSI_CONNECTOR_NUMBER(ucsi->con->num) |
                      UCSI_GET_PD_MESSAGE_RECIPIENT(recipient) |
                      UCSI_GET_PD_MESSAGE_OFFSET(offset) |
UCSI_GET_PD_MESSAGE_BYTES(size) |

UCSI_GET_PD_MESSAGE_TYPE(UCSI_GET_PD_MESSAGE_TYPE_IDENTITY);

        return ucsi_send_command(ucsi, command, data, size);
}

Then in the ucsi_read_identity() :
        u8 offset =3D 0;
        u8 size;

        /*
         * In UCSI v2.0 and after, MESSAGE_IN is large enough to request
         * the large enough to request the full Discover Identity
         * response at once.
         */
        if (ucsi->version >=3D UCSI_VERSION_2_0) {
                size =3D 0x1c;
        else
                size =3D 0x10;

        ret =3D ucsi_pd_message_get_identity(ucsi, offset, size, &resp);
        if (ret < 0) {
                /* Handle error */
        }

        /* Request Product Type VDO1 through Product Type VDO3. */
        if (ucsi->version < UCSI_VERSION_2_0) {
                offset =3D 0x10;
                size =3D 0xC;
                ret =3D ucsi_pd_message_get_identity(ucsi, offset, size,
&resp.vdo[0]);
                if (ret < 0) {
                /* Handle error */
                }
        }

BR,

-Prashant

