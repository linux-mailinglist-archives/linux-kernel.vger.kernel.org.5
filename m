Return-Path: <linux-kernel+bounces-14245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317BC8219D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D6E1C21CE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBCDD507;
	Tue,  2 Jan 2024 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UvbnHLHE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB6FDDAD;
	Tue,  2 Jan 2024 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704191496; x=1704796296; i=markus.elfring@web.de;
	bh=byLjICH9kZFXAhhR7l1uz0KXqLkgIwDGVOFiUikXwjw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=UvbnHLHE18UZfNoQinmJ5WClJpEmsnAxcznti26bUEb4k/E/6paOYmFB8aSKz/xG
	 GIcohZH93ewA8ql7aafpXZG+/Q9As8dU558NPrg+Nj5Ub/Pv/EfQxF7rM43r1+pmp
	 CaVX7o18hFfmmtuugXiXfUE8hNzYfc+pUOo5uFRmtlADn3JVqlU26PLVDuCYrb95U
	 vDaHh2gjjc0U76o70y2YRE0Fynd6B8eFwtQMB+rCVXuW3JF1Mg2Mj1Z12aWrF6Lis
	 +a0gyJ3xkxoKj4e7nTuln7FyT4lyLFzVApgfGhWMhzT0rRiu4ZRIcrGieY0h50IkL
	 D/GkH1p1YzwEULNr4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3ouq-1rBZdI2IAy-00zyNb; Tue, 02
 Jan 2024 11:31:36 +0100
Message-ID: <d2e5c263-c0aa-4297-b446-f013af7eb80f@web.de>
Date: Tue, 2 Jan 2024 11:31:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/iucv: Improve unlocking in iucv_enable()
Content-Language: en-GB
To: Alexandra Winter <wintera@linux.ibm.com>, Suman Ghosh
 <sumang@marvell.com>, "linux-s390@vger.kernel.org"
 <linux-s390@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <cde82080-c715-473c-97ac-6ef66bba6d64@web.de>
 <81f7db31-a258-4dc8-b6e1-c1ef1844a9d2@web.de>
 <SJ0PR18MB5216C27127E46490951A1E5DDB61A@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <8123a895-c7dd-4a75-94bc-6f61639621eb@web.de>
 <SJ0PR18MB52168AC4B874C0B99BD37039DB61A@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <2bf1b0cb-86af-4e00-a0aa-23e3944617a2@linux.ibm.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2bf1b0cb-86af-4e00-a0aa-23e3944617a2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vwvz92Bt8HT7eNV3Wmw65q6wPiFzhtMoY5oZu8ovAx9ruR5aR/u
 +tP5/8TYnDV6TukFkGVK5FHlNA22DelulzoEZ4HDvAoIbdgX2BdHUXHnILdX1b5ZXqgqglj
 2752rA2H4yNc8SQFEC8O7e6onYHBLEmIgsIptaG8+Vx2PzcLuv3KyBsmJPeRPDYWH5FIRAd
 9TnVWIvwtsxF7m2J4alNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N+sZX2iAzmM=;yViQHahgU4NVsBOTP6sDp3nZcfO
 5oYUrWBM77Aet6jAwMVrgn81lJyL1DXbUrttOuRcVw359powYsbjEk8O1jZ+c8sfi961W2PZ8
 x9xQ+iaYA3KjEPYrvbdGmUnz1X5ffXGFVY1p9NptMTtwfCFg4Qsfmhvr1DSYLpgxXsv+jQQnz
 2Wqi3TLx+ZszNN37nuK7ChIPOpUDYpiTUn2/j3lEifMBKjygFkCQRMde6vY6+8tdzaijEY6OR
 zcbAQYOi8YEQNUNvJEr9G5kdtoQv+3tAA3enqPjdQebe3RunU3nGwWT3slutmeI0+nQAHNIdi
 oropFxKVTPI38zpaQdofHwTFa2wtsE3nXIElxTcyZl7Lv/ZCC1vrc31lHTdmyAPNG2Gjq7cOe
 3rj7sUQDGE9pUYc5mSczL81A2jCmI5hxeGAPqKk16aTZBCviJX1bKqQeXXKCvbLTZSNuD8GTA
 EyRwcn9GI0Z0v1PqcdMB5ZuAt+3FABNMIfhfrw/qvVqG0a4D90b2zXEhJ8k6ExtgLV80IDFUx
 vGIvEfaBSWilCrXirD+PT9kjn+J12MrSqpsVvppW93oGcw0E3ZtLQfhJPhvH5VDYSp+B5hYWi
 F9oKQ4spKIuiRKEejNNWUxEtp+e9TQXRvE5WrGa7tUOZA/7JcM9TPRVEVTviB1XB2zT1upa6Z
 jLHQlrJlzwXQH3RlFyiqpGkA06aKeYGNp0DPJK7h6ipbQl+HQjPDnDHT2uXgD2E600tS6DljB
 wDrpHoJ2p9uA1vs62VGjP0qJ3PIKl0uyytsNLNxtPnkmdoi2PhfGz3T1EOg45QIbFe8BcowOg
 KP5SEtlRrrQZKbycwwiHbGAenCBfiowz7LgFx57cBOeAceeTrJEDIXlV+G1H/icMMwMmnkXSg
 JArFpi8UAIeCs/Vtab7nAJObPhw16zi3467zLOB1/aLen15nyZpXdGqxqgf6rzrGm64bSoTUj
 ITVFcw==

> I share Suman's concern that jumping backwards goto is confusing.
> But I think the Coccinelle finding of freeing a null-pointer should be a=
ddressed (see patch 2/2)
> Thank you Markus for reporting it.
>
> The allocation does require holding the cpus_read_lock.

How does this information fit to your following suggestion to adjust the l=
ock scope?


> For some reason Markus wants to reduce the number of cpus_read_unlock() =
calls (why?),

One cpus_read_unlock() call is required here.
Would you like to benefit more from a smaller executable code size?


> so what about something like this for both issues:
>
> diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> index 0ed6e34d6edd..1030403b826b 100644
> --- a/net/iucv/iucv.c
> +++ b/net/iucv/iucv.c
> @@ -542,24 +542,22 @@ static int iucv_enable(void)
>         size_t alloc_size;
>         int cpu, rc;
>
> -       cpus_read_lock();
> -       rc =3D -ENOMEM;
>         alloc_size =3D iucv_max_pathid * sizeof(struct iucv_path);
>         iucv_path_table =3D kzalloc(alloc_size, GFP_KERNEL);
>         if (!iucv_path_table)
> -               goto out;
> +               return -ENOMEM;
>         /* Declare per cpu buffers. */
> -       rc =3D -EIO;
> +       cpus_read_lock();
>         for_each_online_cpu(cpu)
>                 smp_call_function_single(cpu, iucv_declare_cpu, NULL, 1)=
;
> -       if (cpumask_empty(&iucv_buffer_cpumask))
> +       if (cpumask_empty(&iucv_buffer_cpumask)) {
>                 /* No cpu could declare an iucv buffer. */
> -               goto out;
> -       cpus_read_unlock();
> -       return 0;
> -out:
> -       kfree(iucv_path_table);
> -       iucv_path_table =3D NULL;
> +               kfree(iucv_path_table);
> +               iucv_path_table =3D NULL;
> +               rc =3D -EIO;
> +       } else {
> +               rc =3D 0;
> +       }
>         cpus_read_unlock();
>         return rc;
>  }


I suggest to reconsider patch squashing a bit more.

Regards,
Markus

