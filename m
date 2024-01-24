Return-Path: <linux-kernel+bounces-37741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBDE83B4AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99F8286A83
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFDD135A58;
	Wed, 24 Jan 2024 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WfdW4f/5"
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF416C2C2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135478; cv=none; b=sFok/hepIRu+Gj51NZ4QWd1ByRGDMw9li1fLkpicbqsBQL73siXc9+BsPgdjsXoRgxpSUDvNjPPOXIvOn12Y+1d2tb2uFg9/CzkJGm8TYkUAPUP0N0DaN7A/HD/CtGBt8Vp/gGM13RTvV8O0nctBuOm9Awqw+4+rVfbYwn4RS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135478; c=relaxed/simple;
	bh=ncNSKEB8i9H7xvUfioYYp/VoOJk3T8giU+CM5F/GyMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSux8AzUWpluW3YR/I8BSgHyLztixWoeEZ369iR/m/sUWDh+jYQlKONN05J1X1rh/FZtz7blLd3x4eU/AaPXoxbWy7XvUEAfmn7z5wjZHMygUKp+O2dHBFA7SakTsPf0QywscKicOLb+8sLQ5yB3VArWAPdv0CioOUXt8SFPG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WfdW4f/5; arc=none smtp.client-ip=66.163.189.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706135476; bh=K0ouN+nLZSPECn+2C3BZ1Yg4vdvedoKbDa2WyhtFY38=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=WfdW4f/5Ih/OSgNo+DyKRspxX32wxUbEljnupK8L/tmlybaoOAp0hA5BufPxvbdes56X+izqlCnHdW+P3y+bfGoR6u7tO21KUi/GBYsvNFgGHIXbF2PBOWaK1z1NxDQoUKiCu0QmC1iOeFnzfcyaJuqa/+RDXyIFXSk0i04hjrOzDTdLV7vbamwHt9OMzA2IJ802n7AYRotDMpDQyWz3GOsznBIjC2MvSAO8ZhpnxXql2hQzvuQ+RfEsqhqlm/CRUJSLnfin/GaElX3Nq2Y+vc4Bcqx5c2MLQgQKq47twjcLQnMzRuDw/LGXQGId1FvyDEhqizhsDFbc1N0LFyoZow==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706135476; bh=DcO2p7KfHcK7ga62DQFXNKrpo3809blgw1ZKffA497L=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=s2dUkVw9XFE2zhyd5fnK79XZj3QxHpsFex4MxhxZdwR92qYGAH4KmHO3xQWZW7lJuIRb0QIdeWeQ79fsLs6U+fvC1FLG47xOqubEKWjFVTPJHS5NvRnfVRMT8YfTjveldnU/TkGS0C3rYMRw71hTC+dYDgzZR4uzECnS/giJSHP4mTC8wGsDw+uKvBg94PU/tKALGvhd1qXl9v2GukIN4vTg/SHFZnKz9iK1H/e/bUfsP+gsM6Ow9LLs1U+Eq1hVlzvaaUjh/spiY3OrrJF1W3isL4A3bCxpdId7Jp1J0YL+FFa5e9eHSP9jgLyhVGa628Gcg+n+ZPMM+mFIRu6PkA==
X-YMail-OSG: _3ClCVQVM1nWjuWf0B1d1_7qd1yx.3LKY4eSTxK6sKU3EbThvP0op9nLFX7YuaN
 T.1lTdGHyckk.kOm5AhIIVYx4MOVZG4baoEa40ChtfXX1GyGRYesodCnDx_tAV3wsWMu3bmK1Q7T
 meelx_kuN2GYpQ0z7i1T5ZptDdDNYZR_O8nUDT9uXONtZCYwiamPUCwNqc762uPYXYfE6a_nfj_R
 folpvzxtBD7u_GLuPGaLVY4nVmgn4u666D2gxPd.U6f5j63pMagy4CnpO4inedzIOsTttuTuYNsn
 vJLx1wa6UMxA1Zxl0xD6Zj_6Rq7RUQTBJGduc3jcphVlln4YXsfeLp8RWC_k1ySMzzpa2TUMN9Fd
 .22MZ6VUrhfsnT4ixKU0_wrIbiSzTPUaMBZWn1026Lk2Rn7k5KltOJwtuTGuVQtJ_NNuKFtFFu4a
 FvQTrWthk4ylfectSnRIFLX2U62QO6za0TsNWdUPtM4UEagbGXxYhWFybMq2zTsxJEFUpbCG5yJv
 D.BjBYbRLyBwfwxS7ABNPf7W5MM1.wrc2hsgwrjGPV7WpV3S_fHbyRGUNLo8CO5nMSubI0fCriTj
 QZ6FNjnmZN4zz0OHVI_PJFO8fE4DHz7sSfqX2XHzew7WQZegSyGOFtVbAk.AgsDMHO3NzdgzdZ.4
 kklzmTD0ePmMQGCjPan8n5aCGBPkS.GAoGSFqXMizceOhByv1ryKwiQ179BBmcFfYG9tDUKomxJm
 MWmWqzvGaiSlDjDYOkDbUzVF9lapfRuZ.RdICj7hs0BKHfJeDcED8W4f54zUsc8BTD_eIm8vqBe5
 KTQAkqKXsV_EAAGCNlj4596jUOxTQRJmHvA7cN5hkwK7MAe8onOu5k6L3dMwxZ3ixJU3kwxaOoIj
 .htFiTdpPLAvjuxwzlfAUaZUVy5rMF3DVODJreUNzAI7cW49slkuSKGdad0LQBDscl6fDQRyVhb5
 85IAUR158zrgOQcIlORln69bZIT5SX5ukwhRFyQPzTRNdNVoCsB.owHZxyMwQuRtkKnIaGCeNu.B
 rUHSrCvXmfQWWP72pyx4R1UvlxJj.H_s0jS2oLEzlypq6ks.FiNdLbAaRYY4K838f_eJOgWmX9Ir
 6CFblf6oT0jSycR4OPz3ovAxUbMoAwjxJI06oPkVZ21A4Y56NRecNe77DF0ASHzt8KOksuTmPxH1
 9MugJrorMO5LOozLfA6K.kf8BAcXIrlWavV0UeL5FxJoiN6BkrzAMWrUXIVjLQBP_f7N4Sm.b4P9
 tejJgAeuvL0JO7xgKgr7c.N9WPZWt5J3UAnmmV3KNh8iiQ.qt2.bsyL3iZNWtfOFA_3xJOz_P7Gf
 QU_NpTviRNGk_2mJ.MzZaCjpm9NvSVvCo1pO64bco6t59QS3UXOmLq_s.V0wvNYCwFopREdB1Jex
 V4ZwgYWXzteF4j7sIK1ENL0XThjeKljleuJX4LoWwWgAhfj_s4Jd4Kehj1lxSB0hZ_0zcRWk2cyZ
 _Il8EZe87Ne0d5ih4I9_c3AVwut24wjDMza6upIeCd5Dk4lIaHCr.4lOV7pDKJfmHnHmn.x1pKi1
 gs2y7PwJHX.tqV103afr.o8U4VDj0.1FGX9ChNAAm.eLRqIvEOColYnwNaHCsUtIPI9OiD3gUXrg
 rNZopcvJHQClxrnfVdxLEpnvx4Z7aY1ISUKe_yrJZRsOnoLkNh90AMEd48BTVMk3USFmwb3pnJbB
 fcHa6DzxUZoVvnlRF2vkYbwv61Vm9VWVr8dn6fYl.cxhhF37NaqXAkJk3E0gTDKBT9RpTPYoQ2ii
 zVcA61E7BQ8ZIfasw2LNxEmv.7Iu42zBgTAKy8KB5Tq2JpA9pQjS9c8VAFge9PnIPJzSvg.LMGst
 _DXFcszFGFSQ2D6I9sdorn1OnihUwJwdMepU7PNNPTtZaZekK3axqwdR_Ey6PisBzRCeDSH1mwou
 xD6fGJr7qmkaCQ_kMvWcOhRRPc6RAWiHjl1KBCFH9JwWMs4FqZSA9YXjkGOfd9MurPMvyl626rMf
 vpDCjQ7I2UXNqeLuBPSexLOvAkvwANRLj2E5FDHZFf50p9ZEYnrqHbeU1q.k6eW5z6oC.1osuLLU
 eZMEQivgAMgBDmovxK6n__iYK_gTrHFC9XFBZCvE7rLz_uEkh2PEBnGpODOuVjKL7h5tqFmg3Ims
 En.j7nuZzWuhp.ZfX6n7rKGGcRjjsFMN.Qcf0z6u60t6VmArRP95OI8xjh3AcPGRKiJsXJ18QFYI
 VPGPUh_Zoz7CN.mVfi.N2Ypl1r944dD4HTJTQjglGohEOxPx29mK2gndUyoo0XNVzCrzyu.j9hDg
 8vd3DRzie_Qgq
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b3c06742-66d1-4933-9b7c-458d5954b9e7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Jan 2024 22:31:16 +0000
Received: by hermes--production-gq1-78d49cd6df-mnx8f (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c48bb728c9087adeaa06b5a440f689f;
          Wed, 24 Jan 2024 22:31:12 +0000 (UTC)
Message-ID: <53897379-0c7a-4da7-870c-1eb7e822a129@schaufler-ca.com>
Date: Wed, 24 Jan 2024 14:31:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Smack transmute fixes
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231116090125.187209-1-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231116090125.187209-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22046 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/16/2023 1:01 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> The first two patches are obvious fixes, the first restricts setting the
> SMACK64TRANSMUTE xattr only for directories, and the second makes it
> possible to set SMACK64TRANSMUTE if the filesystem does not support xattrs
> (e.g. ramfs).
>
> The remaining fixes are optional, and only required if we want filesystems
> without xattr support behave like those with xattr support. Since we have
> the inode_setsecurity and inode_getsecurity hooks to make the first group
> work, it seems useful to fix inode creation too (SELinux should be fine).
>
> The third patch is merely a code move out of the 'if (xattr)' condition.
> The fourth updates the security field of the in-memory inode directly in
> smack_inode_init_security() and marks the inode as instantiated,

I have taken patches 1-4 in smack-next. I'm still waiting on a convincing
approval for patch 5.


>  and the
> fifth adds a security_inode_init_security() call in ramfs to initialize the
> security field of the in-memory inodes (needed to test transmuting
> directories).
>
> Both the Smack (on xfs) and IMA test suite succeed with all patches
> applied. Tests were not executed on v3 (trivial changes).
>
> By executing the tests in a ramfs, the results are:
>
> Without the patches:
> 86 Passed, 9 Failed, 90% Success rate
>
> With the patches:
> 93 Passed, 2 Failed, 97% Success rate
>
> The remaining two failures are:
> 2151  ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) = -1 EOPNOTSUPP (Operation not supported)
> 2152  lsetxattr("./targets/proc-attr-Snap", "security.SMACK64EXEC", "Pop", 3, 0) = -1 EOPNOTSUPP (Operation not supported)
>
> The first one is likely due ramfs lack of support for ioctl() while the
> second could be fixed by handling SMACK64EXEC in smack_inode_setsecurity().
>
> The patch set applies on top of lsm/dev, commit e246777e2a03 ("MAINTAINERS:
> update the LSM entry").
>
> The ramfs patch potentially could be useful to correctly initialize the
> label of new inodes in the initramfs, assuming that it will be fully
> labeled with support for xattrs in the cpio image:
>
> https://lore.kernel.org/linux-integrity/20190523121803.21638-1-roberto.sassu@huawei.com/
>
> Ramfs inode labels will be set from xattrs with the inode_setsecurity hook.
>
> Changelog
>
> v2:
> - Replace return with goto in the ramfs patch, for better maintainability
>   (suggested by Andrew Morton)
>
> v1:
> - Rebase on top of latest lsm/next
> - Remove -EOPNOTSUPP check in patch 5 (cannot happen)
>
> Roberto Sassu (5):
>   smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()
>   smack: Handle SMACK64TRANSMUTE in smack_inode_setsecurity()
>   smack: Always determine inode labels in smack_inode_init_security()
>   smack: Initialize the in-memory inode in smack_inode_init_security()
>   ramfs: Initialize security of in-memory inodes
>
>  fs/ramfs/inode.c           | 32 ++++++++++++-
>  security/smack/smack_lsm.c | 95 ++++++++++++++++++++++----------------
>  2 files changed, 86 insertions(+), 41 deletions(-)
>

