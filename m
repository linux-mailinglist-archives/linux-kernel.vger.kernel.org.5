Return-Path: <linux-kernel+bounces-37704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CE783B423
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6895F28388F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE94B13540E;
	Wed, 24 Jan 2024 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YtH9TzG7"
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F177135403
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132231; cv=none; b=g/XRaoKxCadBJP4QbxEBQJCK0XbtfSDRQzCZ+isTOzEClYJsI59Xqx4x5FIo2z3kkWjcHjiCgKP7OFG68+2a1yAWQKhIkrH4dbpsV8hgOmV5JRCucpNiWKGQMhMJ26UxgropmoL4lHxvPJWp6ybn37reI7F7OmdXkdaF5qLklUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132231; c=relaxed/simple;
	bh=j9iyNJ1EOsrzQxpUtTqvr0ncAwltHc1F/url79CFuYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFDj27pErZedis27X7LF54Hdtj1r0fwghulCSWhFVhq/7POxtllGnMvkCnJQPodfFzMEoBvgJVb1Z2P0mFc7ptDqrILTXEOypmgrfxNFb83TiVzjAT3grl5QkHOTKG/8vL3Ce3uxo1N7MJ6dx6drGfxb6Qf6i+2+70itGvvwaHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=YtH9TzG7; arc=none smtp.client-ip=66.163.190.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706132228; bh=0A6MdijwVgm70s9hlUr7/2Vkpj41FkL308wLk6/luXs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=YtH9TzG7Brd9lvvSvaRyhGHvfjLq7I39yrZ7fzklWx3hPRvA3p4Un6+Uy2eneKz4pETjI6Oj8ErTSsHIye3/xd8rWAuyPWXXv7lXi1lb7NlrvEf+qKM8CIQjT8m6y1mhpn/Gtjx2ptiVX/wYqWLIWC2t0GFK57rbGExwvbmvvHdE8vADO8U6ZpyNqRWoyn9akhOOCIHkWf+fXnQsmfjNKU3NMNbVq/RrfTrqG3vwW04zG+s0Yri5DP/aBv6WYWr560BMO5WEegRplUVW2h8EMWDJIq9TjplpY7jfncWnOKO9Yx6s4DBeXNFEmJKvnJv9aU1dNNGiKkAm1Z/flllc8A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706132228; bh=kpUXfrUS7KrSm6/np/axz8QMGK42ZhDGTA3MzPb3Kxi=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=J1ti84borgZs6rkZT+KegLBxkLayiouh4eLstjQG5WkgEPULlW/WsqWdIgrF5US7PoOd6Q1sIVDD4Tb1D4IhGkrMq+n06FKeT2qxZxK3tRBYpPcDSkLIWFlNJcByyB+lGXgUAYG/OZSNXETuj5xslVcZj6wbsdNUZsVmcasmmdtQxQLdW7VPOWDinlwHuUWPdBtnPkXSlxsVu4Tuc+pO3HfTQA6Vas4UJKqf3qFEXEPnNo0yPRRfYGeTG50adNzMDFM6QmLA0bEyW1BYTQYgRvtfkhkTBeHwtCxvZjt/TjbjRyzwTac6E1FIwOekeoVSfuSlJg/AexsHsB9nle4ofA==
X-YMail-OSG: AESbeFYVM1kOCB.un0EO9apSvGSDM1WIt_OiCsVYliJzzgYf9M5KIagvdah1xaf
 sbynUH4qlmDryiU9zS38E0t15wMVh9q7XoBtSq5TC2DhbWkJuYuPunCK1HuuCQg2pP8lI4EhsfC9
 HzDg5PgM7GxnPrYmVQ03I4fjE7dpUJDYnRuY0sd9xToxlbBBQ_1hySb_HNy5EwvVcKsvixjjUwGZ
 TpJG5yL3oI.azHE2wkTVKIqRhPduPmB63oOseD4NHZp9QwpIyA6ig4ImOzaaWp9yzDvNn4c54OZJ
 bK5iGVznDh6IVxsN2d2Nw9WHXaSbMDKYV_7mwSNaT1C4W5ElQR_PY8iifY7H0sxuTkc1E_PEVczy
 mhexNTKSqx_gA8T1v.fkJ0f5uQh1_x5I9RXeE0h1hVCnPtVnG79CnTEUG5pHgx9gHqnIEObN3aRR
 UARuZkjaUlzwR7AoRAwlRn7_HLu.FEhrFhLhJg3djVyRjtYgCaF7NIy3p5B2CzJUp_LPw8eHOQ4x
 KjTjA7RiJom_88.9dDdkP1v3SkVp3LUSTLM94IiKcxr_neqRF6oLV2zclzrpA1CDyB59HjLIMuq7
 PHBCeOCATUKxxU2gVcLlAkdUB43u2FrQdmdianP0BCly0rbd8Rb7UD2m.ffHQdt29HWZ8Ee9ef57
 fLHjKIjA.FgABXRexLl0roeqOp_.da2R0ibhhEHcskVTwieIBFtBUJ5fbUv_is47n9MtRRDuQNIy
 S7P8jWO.9GbL8ZqIXrCyDfmYXGgsYZQ6yFaccWf5qwKtNlimByH4g8hBP9igz7VEEyg.tIgxtF7E
 FSbhJKyX630hvX92PWUMiDeiwpTmZ4rnPXKpmxPGQphXSo_T2jRZT0W.tiBwB0UjPnlZwnZNuY4b
 7yJqlHlZzgkQMuyQNB8gmM89MOEA5kyl6O8Un_1HIun1WNjhRvep54MMCQos8yRrwfqn34X8eWsn
 lek53F48XZIZkWngXSmYbOiZPLjRKQ2tODGAwr0tdkGd91cWg4.Ve0KkQ4EuACwQVxQdprTmD8HH
 EDnJ.stpEjV0fShesQCJhBLJ8w7qG_eYaMn52BbakZxzusglNaGybN6_flM3K.Q32SGnhXYX7w2g
 gDMb4lum5iG6Hu.7S5t0Y0lolVbCkXEaAoT04KHf9MTFAL8lC.z6DeOrAOuMzWZ8SMOt2NWwKoKi
 13Spq_vuG33FA0lPFeA4lfurmxLRVarsBwpzC7MB6Q5xEV6rOoHKLI9p2H7G3Lu0Xfmlp9p5xf9z
 vVaLL6YVdmSKxLrUXV46.d1lIBYDwJhwOkcv.jKwZf6CGJpM.Ws9DbaXtg_xl3k0lPxW0NTSS56O
 jfsZ61D33BJ7wBaX0nXGPjhXYEJB46TN4GbzR392OPFG9RYG3uBu5nMn261zY3U1yCk7Immy9hyT
 w61iuUzJmmbOrrzWl46EGY.eYThb5UpakpMRj7VouyFqXDjDK7lGDXXPXdLFIsL.R32HQWOSGiQj
 LFI.UgsNKwwfoPlFgW0CDWX5yoAOKn1.P164TijLS.0vRFHJkPUNUHDGo2wE7yd3kyfTEBHyHxpp
 xyfwT5TE644IUvVCWC4PIrUd77d6fi1UIW.fktEYPU0aaqC.eYMA0cxLZOqnCKSqhvsA_b5NkhhK
 ubEGR9IgnUJOTwKymRwerEt93oMmppQ_.d9h6CmaDu3q7bTR1u3ys5Mpt03QF.qCYIHGnT5XAG9I
 TT4CFfEuy31sIqhVlAFe2WAI4W1JSJS6ktd8PxMPG1r3vygvTrI5ImsVpdFU6D1CksRCP3y8jaE2
 GwLo7XQsUDuapRvqd0HwKQrQ6VqN6_VFRpI.FToAnSkvgK.LJaqySDDsthlys26izKDCRo7H93cO
 W9K3OVcbTIKbuslzx7eKMd9o.CBakwYRxkonbuuLxgMzycaLAAzHrzsQRQZiZlKS_JG3Zc3RK.XA
 XdvWKKsGDUUVY40qpjNi2LgSxGLFS8vHypa9LMXdBDlmIkgYM._O2vYGY0w9K.x48rPFa31OCKxJ
 ZOWjutmP9EhtiBsnI2BXsGqqkysugy_A2aF8ZgOeF8R8VAfWTjUGwFWFJxZygk.51zag33kthBJN
 MXx._kmd3_dYrsQopMaMwhWWFFAbPxPk3DN8X.Cv7KvDv4774HaQmc3EY7EQnGZbNwMmNi6Uh5fm
 axty00VQbbOaF14TbFuihhJABHaJkwszhucFH57j2LnG_vCOThQcZm.ky0ccNhr2HJDJ0KBndlkV
 EPQPqmK2zhB95T_5MQvTfVvDoB2otWX__vHbPs91fqok8eeHVdBuW5xnU..MKcVCKNbrdeMAiB_7
 EVg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a7823e1d-bb67-4c11-98e0-cb460a567784
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Jan 2024 21:37:08 +0000
Received: by hermes--production-gq1-78d49cd6df-xrrtm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 27de38ab2d7ec3af79905f5602158dac;
          Wed, 24 Jan 2024 21:37:06 +0000 (UTC)
Message-ID: <04cd0a0a-63e6-4acb-b80e-a77e4d7d8d84@schaufler-ca.com>
Date: Wed, 24 Jan 2024 13:37:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Signed-off-by missing for commit in the smack tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240125083229.6bba94ec@canb.auug.org.au>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240125083229.6bba94ec@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22046 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/24/2024 1:32 PM, Stephen Rothwell wrote:
> Hi all,
>
> Commits
>
>   39fcdc643c23 ("smack: Initialize the in-memory inode in smack_inode_init_security()")
>   ea2d37d1b553 ("smack: Always determine inode labels in smack_inode_init_security()")
>   da5bea06bde0 ("smack: Handle SMACK64TRANSMUTE in smack_inode_setsecurity()")
>   9c5589ad9d82 ("smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()")
>
> are missing a Signed-off-by from their committer.

Bugger. Sorry, will repair.


