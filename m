Return-Path: <linux-kernel+bounces-13344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E588203D2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 07:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80BEAB2164A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 06:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0123CF;
	Sat, 30 Dec 2023 06:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KMV0nsVr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025841FA2;
	Sat, 30 Dec 2023 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703918766; x=1704523566; i=markus.elfring@web.de;
	bh=MrI+HlTPHjGiVMETAdFalpnGbyZX2n6jfxRAlWoU6no=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=KMV0nsVrGxfofH8a/TpBKu3neLfMhUs+V3VGW6Cn7iLkUp/N6la6vwe/V6d8kWfX
	 BqCnPkVRebmheAolwV9RQpOOA18ke46k1d9XRDo08BjesW4YEeHX7OCCyrhfjFQ35
	 9ZKwhibEeOqxZstAth4zI6FlzJVKlNsbDdq26uvCRmJQEUvBfFCjhLx+mZ0rAHpqH
	 fSy6KXvxdVRZ2dJLcIejyGuHULC9SwZAfGTzDhbhlUSgLx6dhR5zpv/AtNjDMTl9l
	 69Mjr74xO+vCMy6owLxtNrcjbpYCjK9bMU5jCus+PkpJW+rYj1neO8tgTrPePmKBu
	 8UvNi3ZzfOH2Amu/5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjgSv-1qprqH0saR-00kqVE; Sat, 30
 Dec 2023 07:46:06 +0100
Message-ID: <621c7483-9a8c-431c-86e0-85d23b983471@web.de>
Date: Sat, 30 Dec 2023 07:45:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hugetlbfs: Improve exception handling in
 hugetlbfs_fill_super()
To: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc: kernel-janitors@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
References: <9ce3f553-24bc-4ecd-ac5e-7ba27caeff57@web.de>
 <b109b7dc-3972-4b2e-ae4c-89bf8eecf8f2@web.de>
 <ZY7dEbRJb1dHkQPd@casper.infradead.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZY7dEbRJb1dHkQPd@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ve8neiGe2q5ryqxM6dzaXIxfeGHBlbzo1qJcYLsQ4RG1C0BHG4Y
 iVXPNs6/F7b6gq1kCic2vQE8tnCUG8nDZWQ6OteFB4tPYOuO15VfGA+Q0BoFCkjfGjWdOch
 pgEpL5ZqaEBhHT/rwmCXMzu2ZjWuTeuxuQcCMZaf31OwzKx07UoZ7shYeIu9ZlWsIg/gOBY
 QLh0SUQlhJQiX/PYhWGIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M7PlL5FeIXY=;P9CA05MuiTsu8Dx9xQU42UD9CtZ
 LDI4EywlodTtkCBe6x9Sz2G/e0wDw+0kn53GXNqM2o0sisVkvVUAFeQPUpxhC3VKhxjtLfRPW
 /egtBlhmnM6s6MWd2hitASrMibEmiZGchb6CDPKyasJ+azcGFfybofZEzTzAVncYkPqaNEutB
 hYRGUHc8IaWo7/XdbHjOU1skOELwJQ6rgJU2WQT52/VS4TkIl9fOnyJLHjRQVN6ZGhlI81lKD
 oP9HAXrGbSYGb/0+1zIL+CawJ8fRMa3IWu6Fn3Qg8kf6/tQyRQwl0rUhJTyeZlDvDtl/ftFqO
 1oPLgpe7o1+FebxrkOJgbi9iB3BzGAf0BlLiD/0UZLWHj1A+BeCRXH3iWyUSQDL1JeJbC9SbO
 dYDJJKt6heT3OXxlQgrqTI3B4+4JPjGdMbhchQ3MzdsylWZ/Z9pC+QD5QWoVtQdPnsYTiO/+c
 k1I80Eiqa8WfDJJoDZrQm0SN7jEdmgtlrFKn7DHjHFK21JxCMpeHC5aly7xajtYd5nr2A/RmC
 WJabT0ZKJou9U7sTkoUoCG/ek8usKP7FmY02aqWosl3dXWi5Ns9nm1cItEbSP3PXEqQ09TIMv
 x9uBABU6P/Gzs1w6H9kfJTUVfIYLjqP8jUqG2leSfM0oEJPk0awurtYRGjQXr+CeuSnwklxPW
 6YfDKwy9f1OElxm0AGvWpjo5NVic/Mdc8GF313axP9ICGODsYtpTqyrZIFvStTT2waUjvyqSJ
 a0AXAQB9HPHmNLrkmBnVWvIiZTNMTOIGo0KsLO0ck1xO968zG5VdiZNXqFsyOLDNCAJfkf32Y
 cWhdQ1++FjFeLhe/kIxPgV4xRgNB2KFU3inTJBXCemktUDTsWX/SHhl3upzmH+dlpnKqRW6Wy
 7ix7xwFhZvsg6UUc6vRqYgH+NUKvB3K4Q30tPs1BmB78/6UR+C3RIllUFGpUd5XllI5v0zK8S
 ci8axg==

>> +++ b/fs/hugetlbfs/inode.c
>> @@ -1483,7 +1483,7 @@ hugetlbfs_fill_super(struct super_block *sb, stru=
ct fs_context *fc)
>>  						     ctx->max_hpages,
>>  						     ctx->min_hpages);
>>  		if (!sbinfo->spool)
>> -			goto out_free;
>> +			goto free_sbinfo;
>>  	}
>>  	sb->s_maxbytes =3D MAX_LFS_FILESIZE;
>>  	sb->s_blocksize =3D huge_page_size(ctx->hstate);
>> @@ -1499,10 +1499,12 @@ hugetlbfs_fill_super(struct super_block *sb, st=
ruct fs_context *fc)
>>  	sb->s_stack_depth =3D FILESYSTEM_MAX_STACK_DEPTH;
>>  	sb->s_root =3D d_make_root(hugetlbfs_get_root(sb, ctx));
>>  	if (!sb->s_root)
>> -		goto out_free;
>> +		goto free_spool;
>>  	return 0;
>> -out_free:
>> +
>> +free_spool:
>>  	kfree(sbinfo->spool);
>> +free_sbinfo:
>>  	kfree(sbinfo);
>>  	return -ENOMEM;
>>  }
>
> This is more complex.  NACK.

I am curious how coding style preferences will evolve further.

See also:
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es

Regards,
Markus

