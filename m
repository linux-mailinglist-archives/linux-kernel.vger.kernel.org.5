Return-Path: <linux-kernel+bounces-119989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5EF88CFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AD9329978
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD2613D63C;
	Tue, 26 Mar 2024 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4TvLwH6"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0D712B158;
	Tue, 26 Mar 2024 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487568; cv=none; b=WsTMO8Y6P+hzDVvPZjA9gOplCSA4frLzvo9TnDoS8bh9cAHMHyrZYrYoX7Oldv+906E4JBqiPsN9SP9fqsS76vPVfI8DyxA3L871dtfawgYHbfHdZcFwELnelqtDb4fDLpbCYzSykyZ6HOghjnYhM/yelIalrAYIUPnnUPLgBwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487568; c=relaxed/simple;
	bh=GgiN1rR40DFXM8BB0Ihu9YB/0ouqwd1ClICGhO/y0AQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlHjOabf+nv3pxTOg66p/GznhUc16EbfoeYbwwCrsjyV5x3VtF42tzHVbiYHE7ffvLvOABLe8lAt/Sg7ibjGkzsb9NkfzIBBLhfndkH/XyW2Tu3gk9BTekjHfcebt4yqxAQM0tjmu1fDPA0n3MZM6DnGOj9LgxMo+jbETsISet8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4TvLwH6; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d6ee6c9945so6903201fa.3;
        Tue, 26 Mar 2024 14:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711487565; x=1712092365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6N3pMHLnMOeWnm2e7SHEMqTaVlX3nJGjf1SAYTtIV1Q=;
        b=P4TvLwH6f0gzpjkVZ1jRhgKZL+165RI4amnHjlhhKJi44IuCZSXZg/UKFaupZ5crmS
         6l89SoCDzjK2htP6Jo9I8XnFxpJPI9Gll+gzs4wfnrMFOmzlVUrCZwM7HBI3dYHJXKcV
         FTY/fb6RnS2bDnggKncqXvlNsU2P28+UOirUCRuzaZt2NhyDU2qKGvpQ+6W7OruKZGr2
         iQmdwrVsL6h5WHb14jwEgBm/fWUFhfsvZfnOG8WjhKXDIM6MixGbKkuPBOfeyFsT/LQ/
         kN0SMn4XNSVyfOzpvdeErqRD4qYhj0SzqUUURqv3BxcRcevswWh0bkDj2s2GQhz6IRWp
         o/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711487565; x=1712092365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6N3pMHLnMOeWnm2e7SHEMqTaVlX3nJGjf1SAYTtIV1Q=;
        b=YLjV1wwoB6/9DdlgMU0grOG57uqoGG2x3F5Wvxgia7Jh3PftIXvnCjnB9vA+WgsuB2
         UW96je6YXxKsFHwfb5pmb9vf9gwfhOtVzVEqDTPj08YCKxLQQh9bf6G/0Ns5AA3mSKss
         yLtMRjWnctYL5Irf5uAqFDOFAJbEJxqvZapnnN4BuHjySft5nLetFo58XgmHeXINnxQb
         tjzg1zab8zdxxHH6Vlvr0GBNFQdMBOQtA+PGjMkGmlda84JXrErJ9aqrCnMoO1Rx/HJl
         VmCnjln5kfK/3pyeOM9ZMyhg6HfUTd8B3d9ht2kJrp/A6CR5SVwnc/gTBh7lC7ZXUGHX
         1Aog==
X-Forwarded-Encrypted: i=1; AJvYcCXjvt8jPlMzErV5dRrGfJuZLiIcGHoWIkdhKn8co8ASJJ+LOHf73C/TQHS6itLmTnl6LTczZor+LPAnNB/mB/CtIwHcgwin1ZjDxxkYkNua/QNM83plAm78E3D6jNbwdTC9vzvfjsT8J5tfJ2SsU1BgbmWsi/BuuWOwAA+9jPhKS2LUOX82xhY8RULW8xUYTbkCgYnQY4pF6KDDhUOmucSlHGhrHCBl
X-Gm-Message-State: AOJu0Yz09LE8K6FEnR4kaD47m9tC8jw4xROWpGiVyX+q/6EnRa4DUr/i
	/1aF17Ju6FAsMWZ3oBix+/+xZTAjJjSQIClZIRXrxDU0ievh+cnOoaOGRoDPqEsIl5RFMgo67Of
	j1Pg1ps6M/jTIYjgmp3akO7lVnSQ=
X-Google-Smtp-Source: AGHT+IG8rZIWonuEpmxYokyuUFPJeUuOA/h9yNnAuKbMjBZUxrYy5jsNoqVKRYP0gmFOeazcjJP8usb66EVkU9S3uZI=
X-Received: by 2002:a2e:2416:0:b0:2d4:5d44:fe1d with SMTP id
 k22-20020a2e2416000000b002d45d44fe1dmr1614652ljk.52.1711487564624; Tue, 26
 Mar 2024 14:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZgMpynzZ8FltPCi3@neat>
In-Reply-To: <ZgMpynzZ8FltPCi3@neat>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 26 Mar 2024 17:12:31 -0400
Message-ID: <CABBYNZ+N5UM3pvTiMSNx-EhhTOOXwEziO7BQoYK+u8=TtSQEnw@mail.gmail.com>
Subject: Re: [PATCH][next] Bluetooth: L2CAP: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Tue, Mar 26, 2024 at 4:02=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
>
> There are currently a couple of objects (`req` and `rsp`), in a couple
> of structures, that contain flexible structures (`struct l2cap_ecred_conn=
_req`
> and `struct l2cap_ecred_conn_rsp`), for example:
>
> struct l2cap_ecred_rsp_data {
>         struct {
>                 struct l2cap_ecred_conn_rsp rsp;
>                 __le16 scid[L2CAP_ECRED_MAX_CID];
>         } __packed pdu;
>         int count;
> };
>
> in the struct above, `struct l2cap_ecred_conn_rsp` is a flexible
> structure:
>
> struct l2cap_ecred_conn_rsp {
>         __le16 mtu;
>         __le16 mps;
>         __le16 credits;
>         __le16 result;
>         __le16 dcid[];
> };
>
> So, in order to avoid ending up with a flexible-array member in the
> middle of another structure, we use the `struct_group_tagged()` (and
> `__struct_group()` when the flexible structure is `__packed`) helper
> to separate the flexible array from the rest of the members in the
> flexible structure:
>
> struct l2cap_ecred_conn_rsp {
>         struct_group_tagged(l2cap_ecred_conn_rsp_hdr, hdr,
>
>         ... the rest of members
>
>         );
>         __le16 dcid[];
> };

Wouldn't it be better, more readable at least, to not define the
l2cap_ecred_conn_rsp_hdr inside thought? Instead just do:

struct_group_tagged(l2cap_ecred_conn_rsp_hdr, hdr,
..
 };

 struct l2cap_ecred_conn_rsp {
        struct l2cap_ecred_conn_rsp_hdr hdr;
         __le16 dcid[];
 };

Or was this done this way in order to maintain the same fields?

> With the change described above, we now declare objects of the type of
> the tagged struct, in this example `struct l2cap_ecred_conn_rsp_hdr`,
> without embedding flexible arrays in the middle of other structures:
>
> struct l2cap_ecred_rsp_data {
>         struct {
>                 struct l2cap_ecred_conn_rsp_hdr rsp;
>                 __le16 scid[L2CAP_ECRED_MAX_CID];
>         } __packed pdu;
>         int count;
> };
>
> Also, when the flexible-array member needs to be accessed, we use
> `container_of()` to retrieve a pointer to the flexible structure.
>
> We also use the `DEFINE_RAW_FLEX()` helper for a couple of on-stack
> definitions of a flexible structure where the size of the flexible-array
> member is known at compile-time.
>
> So, with these changes, fix the following warnings:
> net/bluetooth/l2cap_core.c:1260:45: warning: structure containing a flexi=
ble array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
> net/bluetooth/l2cap_core.c:3740:45: warning: structure containing a flexi=
ble array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
> net/bluetooth/l2cap_core.c:4999:45: warning: structure containing a flexi=
ble array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
> net/bluetooth/l2cap_core.c:7116:47: warning: structure containing a flexi=
ble array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
>
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>
> Hi!
>
> I wonder if `struct l2cap_ecred_conn_rsp` should also be `__packed`.
>
> Thanks
>  - Gustavo
>
>  include/net/bluetooth/l2cap.h | 20 +++++++++------
>  net/bluetooth/l2cap_core.c    | 46 ++++++++++++++++-------------------
>  2 files changed, 33 insertions(+), 33 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index a4278aa618ab..92a143517d83 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -463,18 +463,22 @@ struct l2cap_le_credits {
>  #define L2CAP_ECRED_MAX_CID            5
>
>  struct l2cap_ecred_conn_req {
> -       __le16 psm;
> -       __le16 mtu;
> -       __le16 mps;
> -       __le16 credits;
> +       __struct_group(l2cap_ecred_conn_req_hdr, hdr, __packed,
> +               __le16 psm;
> +               __le16 mtu;
> +               __le16 mps;
> +               __le16 credits;
> +       );
>         __le16 scid[];
>  } __packed;
>
>  struct l2cap_ecred_conn_rsp {
> -       __le16 mtu;
> -       __le16 mps;
> -       __le16 credits;
> -       __le16 result;
> +       struct_group_tagged(l2cap_ecred_conn_rsp_hdr, hdr,
> +               __le16 mtu;
> +               __le16 mps;
> +               __le16 credits;
> +               __le16 result;
> +       );
>         __le16 dcid[];
>  };
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 467b242d8be0..bf087eca489e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1257,7 +1257,7 @@ static void l2cap_le_connect(struct l2cap_chan *cha=
n)
>
>  struct l2cap_ecred_conn_data {
>         struct {
> -               struct l2cap_ecred_conn_req req;
> +               struct l2cap_ecred_conn_req_hdr req;
>                 __le16 scid[5];
>         } __packed pdu;

Can't we just use DEFINE_RAW_FLEX for the pdu field above?

>         struct l2cap_chan *chan;
> @@ -3737,7 +3737,7 @@ static void l2cap_ecred_list_defer(struct l2cap_cha=
n *chan, void *data)
>
>  struct l2cap_ecred_rsp_data {
>         struct {
> -               struct l2cap_ecred_conn_rsp rsp;
> +               struct l2cap_ecred_conn_rsp_hdr rsp;
>                 __le16 scid[L2CAP_ECRED_MAX_CID];
>         } __packed pdu;

Ditto.

>         int count;
> @@ -3746,6 +3746,8 @@ struct l2cap_ecred_rsp_data {
>  static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
>  {
>         struct l2cap_ecred_rsp_data *rsp =3D data;
> +       struct l2cap_ecred_conn_rsp *rsp_flex =3D
> +               container_of(&rsp->pdu.rsp, struct l2cap_ecred_conn_rsp, =
hdr);
>
>         if (test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
>                 return;
> @@ -3755,7 +3757,7 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan=
 *chan, void *data)
>
>         /* Include all channels pending with the same ident */
>         if (!rsp->pdu.rsp.result)
> -               rsp->pdu.rsp.dcid[rsp->count++] =3D cpu_to_le16(chan->sci=
d);
> +               rsp_flex->dcid[rsp->count++] =3D cpu_to_le16(chan->scid);
>         else
>                 l2cap_chan_del(chan, ECONNRESET);
>  }
> @@ -4995,10 +4997,7 @@ static inline int l2cap_ecred_conn_req(struct l2ca=
p_conn *conn,
>                                        u8 *data)
>  {
>         struct l2cap_ecred_conn_req *req =3D (void *) data;
> -       struct {
> -               struct l2cap_ecred_conn_rsp rsp;
> -               __le16 dcid[L2CAP_ECRED_MAX_CID];
> -       } __packed pdu;
> +       DEFINE_RAW_FLEX(struct l2cap_ecred_conn_rsp, pdu, dcid, L2CAP_ECR=
ED_MAX_CID);
>         struct l2cap_chan *chan, *pchan;
>         u16 mtu, mps;
>         __le16 psm;
> @@ -5017,7 +5016,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap=
_conn *conn,
>         cmd_len -=3D sizeof(*req);
>         num_scid =3D cmd_len / sizeof(u16);
>
> -       if (num_scid > ARRAY_SIZE(pdu.dcid)) {
> +       if (num_scid > L2CAP_ECRED_MAX_CID) {
>                 result =3D L2CAP_CR_LE_INVALID_PARAMS;
>                 goto response;
>         }
> @@ -5046,7 +5045,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap=
_conn *conn,
>
>         BT_DBG("psm 0x%2.2x mtu %u mps %u", __le16_to_cpu(psm), mtu, mps)=
;
>
> -       memset(&pdu, 0, sizeof(pdu));
> +       memset(pdu, 0, sizeof(*pdu));
>
>         /* Check if we have socket listening on psm */
>         pchan =3D l2cap_global_chan_by_psm(BT_LISTEN, psm, &conn->hcon->s=
rc,
> @@ -5072,8 +5071,8 @@ static inline int l2cap_ecred_conn_req(struct l2cap=
_conn *conn,
>
>                 BT_DBG("scid[%d] 0x%4.4x", i, scid);
>
> -               pdu.dcid[i] =3D 0x0000;
> -               len +=3D sizeof(*pdu.dcid);
> +               pdu->dcid[i] =3D 0x0000;
> +               len +=3D sizeof(*pdu->dcid);
>
>                 /* Check for valid dynamic CID range */
>                 if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN=
_END) {
> @@ -5107,13 +5106,13 @@ static inline int l2cap_ecred_conn_req(struct l2c=
ap_conn *conn,
>                 l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
>
>                 /* Init response */
> -               if (!pdu.rsp.credits) {
> -                       pdu.rsp.mtu =3D cpu_to_le16(chan->imtu);
> -                       pdu.rsp.mps =3D cpu_to_le16(chan->mps);
> -                       pdu.rsp.credits =3D cpu_to_le16(chan->rx_credits)=
;
> +               if (!pdu->credits) {
> +                       pdu->mtu =3D cpu_to_le16(chan->imtu);
> +                       pdu->mps =3D cpu_to_le16(chan->mps);
> +                       pdu->credits =3D cpu_to_le16(chan->rx_credits);
>                 }
>
> -               pdu.dcid[i] =3D cpu_to_le16(chan->scid);
> +               pdu->dcid[i] =3D cpu_to_le16(chan->scid);
>
>                 __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
>
> @@ -5135,13 +5134,13 @@ static inline int l2cap_ecred_conn_req(struct l2c=
ap_conn *conn,
>         l2cap_chan_put(pchan);
>
>  response:
> -       pdu.rsp.result =3D cpu_to_le16(result);
> +       pdu->result =3D cpu_to_le16(result);
>
>         if (defer)
>                 return 0;
>
>         l2cap_send_cmd(conn, cmd->ident, L2CAP_ECRED_CONN_RSP,
> -                      sizeof(pdu.rsp) + len, &pdu);
> +                      sizeof(*pdu) + len, pdu);
>
>         return 0;
>  }
> @@ -7112,14 +7111,11 @@ EXPORT_SYMBOL_GPL(l2cap_chan_connect);
>  static void l2cap_ecred_reconfigure(struct l2cap_chan *chan)
>  {
>         struct l2cap_conn *conn =3D chan->conn;
> -       struct {
> -               struct l2cap_ecred_reconf_req req;
> -               __le16 scid;
> -       } pdu;
> +       DEFINE_RAW_FLEX(struct l2cap_ecred_reconf_req, pdu, scid, 1);
>
> -       pdu.req.mtu =3D cpu_to_le16(chan->imtu);
> -       pdu.req.mps =3D cpu_to_le16(chan->mps);
> -       pdu.scid    =3D cpu_to_le16(chan->scid);
> +       pdu->mtu =3D cpu_to_le16(chan->imtu);
> +       pdu->mps =3D cpu_to_le16(chan->mps);
> +       pdu->scid[0] =3D cpu_to_le16(chan->scid);
>
>         chan->ident =3D l2cap_get_ident(conn);
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

