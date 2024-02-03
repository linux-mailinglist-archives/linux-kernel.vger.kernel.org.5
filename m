Return-Path: <linux-kernel+bounces-51294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D21DD8488E6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA85B245F2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F0012E6C;
	Sat,  3 Feb 2024 21:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EueN6gsi"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1461712B60
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706994778; cv=none; b=d3AkyADVBXYPrf8R1S2zCvqdSyEt60aYXIGBMAm4cbdRIY3zxrnXGcV4+swZYM4nzfi6tRpPRy8xxOG6nne4mwXA14xjzutn4Pi4UioQ92DvBlBWU53T/aj4IM0cWLIpnjItsqjy+ANjMUOHgpC3bPkE1Ctz+Co1JWDGnfUCki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706994778; c=relaxed/simple;
	bh=b+rkN+Hlt3A/DwTimq5lrVliob2o5z8DCJmdWPNIzqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXHkBr5NNZEmCYDRTZKUZOj1Icpi1CJf16e3pej7quxkUAZ8TdlLsLAyM4TF8W0LM38QMRZs1fYbDRjsWk4W6aQ/cKLNIUXVXeW5scWTfO6J/bZGFaxDOcEUEYZlH8MeViUmDWZCXWsFjnJIJXeAUgjbgG4EHyfUT27Ctuve98I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EueN6gsi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so3706558a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 13:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706994773; x=1707599573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wTplBP8Qcn6WEm+IfMMBshhvnI94zgtW6tqzNQZV3o=;
        b=EueN6gsiHiUuUfP1eo6lUofn/PauAvMmUWL/fz12neY9QrO5F3D4e4+9hKGESsssII
         aZ/e+EV+Aj1g+m64I6g55xv5xLmiyK97F1Fef4YYdzB20xqltYDUEsHId+Uf3sqkeipr
         nVZjkrQ0+gZkFc6YqKGW3hIiUj7DjLG48VaZwoD8tI8PX6MpGL4DCLs2dTrphJM7dyQJ
         oSsPcXpUpTkpbwCNTbG/GcUQs1AxRFSoxn9th6Dck5kwBDuQY/1eluyNmS5E2sTnj52l
         57Whp5CIpmyXLMoYN5hXwIqmvJHpC+qU9SWOWj9g8IOCNZ3GCQeCmCjCEbiAAFr7g0/+
         hy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706994773; x=1707599573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wTplBP8Qcn6WEm+IfMMBshhvnI94zgtW6tqzNQZV3o=;
        b=pUrFAQnw9a8yPbycBcBX5bHD3wlBEExAWNzt+gqROquuvAb5pgkT8cUWVpQLo4WBht
         pjX7HD/G2REYXlEpE/3dDRJmMA4wc4emSM9rjEFWPgD6E7xJQXScxXqTd2Eu1Af4/C/+
         8SEXJzWd/RY8ZVhOtZORpLwJPkxuodTmtB1u2T+498pgU9mdMwxXLpoUtxGdL1qhArqj
         pvYwmU1+zql9d4cFKesxQMUVaRC4SqJzbtJEYaaVEg7RMJo8ob05yr9uDqSpoUoL4+eD
         bMq8ALtZiQjcIGNuSu/bo7w3cOO+lWoc89f9iFx35yA+JYTWfeUx0Q9QAM70p8icm65N
         w15w==
X-Gm-Message-State: AOJu0YyVLxLHKB4cvs2g9kZgxt/ij73EKMP2mi1T4nMqkn1SqNdFs5lr
	IQsFVmrHoA96nge+GgKO3EB4pwIr9iZMYbkjHRYQ5m0DCiTHk8UHF+M7j5ryOTvILr/8uLDwtwe
	LMRTtmIQzMCYp5o1oyTVjUUv6sWIOfIhqM4Ov7w==
X-Google-Smtp-Source: AGHT+IEGoiNFUl0Dwwy9lPMjgRLlhp7n4f3jaYGITsQkXcq9/Tm4eark0VsUXO5FFUNzfJVZq7X2aB4mQTahpMCQowQ=
X-Received: by 2002:a05:6402:1615:b0:55f:2c48:abe0 with SMTP id
 f21-20020a056402161500b0055f2c48abe0mr2372686edv.23.1706994773306; Sat, 03
 Feb 2024 13:12:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203-bus_cleanup-scsi-v1-0-6f552fb24f71@marliere.net> <20240203-bus_cleanup-scsi-v1-2-6f552fb24f71@marliere.net>
In-Reply-To: <20240203-bus_cleanup-scsi-v1-2-6f552fb24f71@marliere.net>
From: Lee Duncan <lduncan@suse.com>
Date: Sat, 3 Feb 2024 13:12:42 -0800
Message-ID: <CAPj3X_UbiLY4MQaUjHkijpSi1LvjG-1BSfO5td7rk__2weshZQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] scsi: iscsi: make iscsi_flashnode_bus const
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Hannes Reinecke <hare@suse.de>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chris Leech <cleech@redhat.com>, 
	Mike Christie <michael.christie@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, open-iscsi@googlegroups.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 10:38=E2=80=AFAM Ricardo B. Marliere
<ricardo@marliere.net> wrote:
>
> Now that the driver core can properly handle constant struct bus_type,
> move the iscsi_flashnode_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/scsi/scsi_transport_iscsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_tran=
sport_iscsi.c
> index 3075b2ddf7a6..af3ac6346796 100644
> --- a/drivers/scsi/scsi_transport_iscsi.c
> +++ b/drivers/scsi/scsi_transport_iscsi.c
> @@ -1201,7 +1201,7 @@ static const struct device_type iscsi_flashnode_con=
n_dev_type =3D {
>         .release =3D iscsi_flashnode_conn_release,
>  };
>
> -static struct bus_type iscsi_flashnode_bus;
> +static const struct bus_type iscsi_flashnode_bus;
>
>  int iscsi_flashnode_bus_match(struct device *dev,
>                                      struct device_driver *drv)
> @@ -1212,7 +1212,7 @@ int iscsi_flashnode_bus_match(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(iscsi_flashnode_bus_match);
>
> -static struct bus_type iscsi_flashnode_bus =3D {
> +static const struct bus_type iscsi_flashnode_bus =3D {
>         .name =3D "iscsi_flashnode",
>         .match =3D &iscsi_flashnode_bus_match,
>  };
>
> --
> 2.43.0
>

Reviewed-by: Lee Duncan <lduncan@suse.com>

