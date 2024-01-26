Return-Path: <linux-kernel+bounces-40336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD183DEB1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAD328B575
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DFB1DA59;
	Fri, 26 Jan 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hP/cKyvo"
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905BA1CFB6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286480; cv=none; b=mJxP5J9uF5Ylt6XbH4SQDSn5MCVO9RkBfniW++K3Az8RpdVF0n1GVw0ZFb/SNcv61O4NGHhc7j4rwzBBs4fPJL+191BteMH1EK0Qb+045Igl0I6cwAwqnweybtQ74OH36r+tlf07ByD+WgZcp9oD0sbhPiG+HFkUwYsxUXosaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286480; c=relaxed/simple;
	bh=uBpXVHuCOFTsx+vuJnujVz8qUj6Zs+G5qH6j2qFn8xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pk20TJPS9J04uHLKnyuzIdjTP0xAx1XVWeBSc+OJ6Lo7e43Vzq0BTU9pNOZ/Unw4Q9Qu9YVQhIzEsBNs0wBTe/ygkGRd+aqtKTbAz7UKZjbYXnztskp6oIBNiGrSPIBWOmJG0yVpSqt7QOeufhsFnPNtjM143W00sEyO843Mqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hP/cKyvo; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706286476; bh=XMhKS36C0L92F8+OoWMyMKliBsxEpHaehMkZb2PI+Wk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=hP/cKyvopJwxqZz3BiXCj4EXifRT0hIliYSDx62coH4msYxXmwANna7NqAucJnEkrV5+Bm40ldw12FXTi0TFmKiNEf0kq3XKIZG3wLoYpRbMkx+SeK56NGKt9vrSvd7g2AFA6coZNDoXnTIfSSnWeYuCg17ECEX+1i/ij1fuQO5rxs7kpiNa26IPSkPAdwHSrGnbRCkupe7NsUNZ3PSIjQhqfxXFY/S4lj0+SmfmPgh/Wsqr46f9jD7Urhjw1UlkgJEnJkPw2gKUa5sjO79a8JpW653kZ8Dc+4D8+9BmzLaJ16NV5x4g9Y+989BQv/D7AJZyb5hz9oSf4mgUCbYjgg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706286476; bh=BFQEzvhm2ZG89LYwQdhIe5gmMlctkLYmDwUlROlddAu=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tEEOOqx9ZIqszqNfZ8v/On7TyHYcxgyIL7wZucQz3nvgbY0TF5RfAQSMuF9j1/cDnHhz307RrxuBON0hrD/9M8Nm891pv4iUsrmZ2WHl1jPdHN33S6PwbqGrKSnTj9Ob0Nntl2rnJ/K+MsVVZBrzfAuWXl98VB2NBAXuSVNYHG9ev6+Bm9j7f7m/Et8K1Ic/MUc8IcHwb9J2B8d2Bs9LNQmF05r1vwJikfrNrbqAAH3/txnBwPXgNua8oR+bGGZBwOotTGtQj73ufbbuy2Vfs+KovBx20RtgcdvuBoQq8AXD//U/Cd6e2HaJT69jrZ8qZ6/nZtROae5dCiNKZmB3wQ==
X-YMail-OSG: fTa_7uQVM1lQBhQnbc0PVJRbVTiZkHa4dy3sF2XzfBEJ_MJcDILO5G_D78cfM_D
 cUZ5vH19rx4At58PnzYcV7lSoTzv7j71T_VTEb0.Y1twM4iPsb8tHefhl.BAE.15tquAB1rEd6rA
 hRt3XHK1wioA5aAArkbCP6aP0Igp1ynO.ezl5UXWsfonuUtPJ35D6VdXRfzofcNxqXatRXY0acy3
 bAwz3GyZ42xapOAaTKypv4aytYB9F_yaZNjckmRWTlAy1bgmzemfPJtvBGMVJt8hodzKJXq97WeC
 8gg9_6ABz_noAlgj8kiJFKm8tJHxBsIVEtmNQYSJtnoexNaZTgLKdfnyAOwvAxgNvE0J0m4Y1Qys
 GkvT5SP4n.Ifs2IeE57dHg_AV_2nzHh08TUU30lqrFoIp5MOdGj__xR6YmuHhrUrMr67hqcuzJKY
 YyuQXqFMeb0cRSUmi2Q9HvBJiH03vF901CWdCLOVoup3vvCICq1cv.hvkpNOa4ir02hx7nzKsEcd
 iGXG7aYrUPD4RdwDJ9eUBlK_tbt2UvJl2zR0pIRNV1BTwGAll.SvY96N93HkOR5rNRECmOVVwZtS
 TKRxICCwElHSvp4t.zw_LcH0KzLsbly_8uT73VZOXFAnj4aE552Leoo.uP8MVM31GwjBXZOW.Ivg
 c3GUhAqXyGo4h8jVIQLG_m_56U0b.Jb_LcwiTK3oI4xsSDrWSBFXguJS5hQmgK18r.NZXRJKuoMN
 C90LDaFFikCiQw6ACElXwQTnNZv5jkPSm4KG2STaqGYSbQK7vr0HTieRmAMUlrcgNC843VnywMnc
 _um5Q3TFSw59Evpx.BOKthsqmAjzwcE_9YRTY.ffs8eDGgmsOzOKyegRejSdPzfGGQY.Vl7dMePK
 kvU9Z6odnyo8MJb.q2jwS4Cg7gV8j4j4kRazoBy51ul7eycPTpyRdFm6qEot2XPDCvqYpux3qvtt
 qDMY.FN7SFTVohPKBpInUnR7X4A8Y8yiFOBDwKt269JH7bHq.5PHvFGGkpAiKW1xO5ri0DJ6sflQ
 GPwrPSCF.ay59UM5.F_R.0vnv7yHwfMNOgywucOPt5R2YQvO84nWIGq0j7fCMahfjTSDzuo90GSj
 qT2RQnpfBIa0Unt1hWKIUtFZqS.lsrGLOoqeeabTDzLXxzeKzWaxjYaSN0pFRf7uHVM_0egM0Ybm
 NEz.JiHNRy7ftN3qNKEd95tyKOA_K5Bgmkt3tCk2HPn0oXFGz7fxh7nGEBkY4e3X5OAA7eaQubGN
 G5wCzcvAxmCMLic8aT4z2gbqLUhxwT_hp7Nb31zX2BOIih74IuhowhfXIPrT66gC8tbU3aqqOLcJ
 iJ5pws7Z8D9Sory08MrsUykt709oNyOPTpLEWKX283xBUmsWbbiHVOhVfVsdk1fZcg4pTMOr3lZq
 N5ClZUlErnSg3alPTwNZlRg_TfCOyVceW7CNZCxUOBboKzRrtKf0fHVIMwZUwQh3qkxnwnCzptIQ
 d9bh.i3vN0QowOKVLg_rS8gOP5VSe2fu6LuQs3iNu5SI2cfPQDtqaz3CPusXMHmO8_SvoIS9rddB
 6THHRmmrFd_ZP1cjxQUz1eKFUDkL.qY7Z1lKMw0mXQXFcgA2JigNwKyOb5Ysw2VBmShNw.dE9JGJ
 MJWzS1NMgd1C3h31.iSxE6lsfQmJLA4ueRZJRs9xQCEMFlF4NOT8e5rTnC_fqaOtoVAirwzfdtD8
 h2.4j1HYUfm6RL1yaGDw4PF1lu4OqdoDDEKrkah5.I5esLnFpNJYJPqHdpMaSd4U4EQTasV.HqrP
 ePksn7PO9hf1R7XSQlo3biX4_qcrrTe1T01zWraA9CcVTfhB._aHuqb7EZw9ngMVRKjgxXSEk7Cy
 92E0GxKAaeHkJd_Ljxc9B8kaNRt9HEz_Ldj27klPjaLoR3PGq0jl1nbuVZV2JGx5tNloFhDimd8z
 kya.WWYXhV3GZhnWgfhZF6Sd9BlrVg7OzCfzHpOhGg6HF6Ft954cBAftnJlXaP7VR8RDqjgmzLZ9
 6ERWPZjrYbFv1qIwIUR53LH1xSTPfv6zj5xW2ksrZ2q.L3OmS3ontH0gOCr7Gr8V6dPkbDPbNBjE
 vBus.b.vBxwufFbH6pb7P2llacLlY_iU3j0KNv1K_IEZnjGVPLUcp0xBtshrXL3KRSe1XpDJeWqU
 QHcf_.OExekHdbg_SYNp79aRproab.eejtZ9PsVGCDlJ5lwlz.WX5rDaC3lXbHIGsx6qflGD2fHG
 MP5hCld4tSIpelS6kXSYBi_aPha6DImGPBgvxBvh9N_3KlnMa.vQwaRWUg78jLt0AoE_6fn3nNi5
 lIbA2x51oP1BCVg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c0453977-bfae-499e-9c43-dba4ff19f1bf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 26 Jan 2024 16:27:56 +0000
Received: by hermes--production-gq1-78d49cd6df-qtpm7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d3f639f8be7ee05d06416705f1454521;
          Fri, 26 Jan 2024 16:27:55 +0000 (UTC)
Message-ID: <cb451085-50e3-4e76-a03f-5bdff55c7e47@schaufler-ca.com>
Date: Fri, 26 Jan 2024 08:27:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] ramfs: Initialize security of in-memory inodes
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>, Hugh Dickins <hughd@google.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231116090125.187209-1-roberto.sassu@huaweicloud.com>
 <20231116090125.187209-6-roberto.sassu@huaweicloud.com>
 <20240125170858.1ce723a57c7fd2b9bfb5d28d@linux-foundation.org>
 <3e1ebbbeea1db01183bac0a7d0fa9063cb862f81.camel@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <3e1ebbbeea1db01183bac0a7d0fa9063cb862f81.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22046 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/25/2024 11:53 PM, Roberto Sassu wrote:
> On Thu, 2024-01-25 at 17:08 -0800, Andrew Morton wrote:
>> On Thu, 16 Nov 2023 10:01:25 +0100 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
>>
>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>
>>> Add a call security_inode_init_security() after ramfs_get_inode(), to let
>>> LSMs initialize the inode security field. Skip ramfs_fill_super(), as the
>>> initialization is done through the sb_set_mnt_opts hook.
>>>
>>> Calling security_inode_init_security() call inside ramfs_get_inode() is
>>> not possible since, for CONFIG_SHMEM=n, tmpfs also calls the former after
>>> the latter.
>>>
>>> Pass NULL as initxattrs() callback to security_inode_init_security(), since
>>> the purpose of the call is only to initialize the in-memory inodes.
>>>
>> fwiw,
>>
>> Acked-by: Andrew Morton <akpm@linux-foundation.org>
>>
>> Please include this in the relevant security tree.

I will take this in the Smack tree. Thank you.

> Thanks a lot!
>
> Roberto
>
>>> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
>>> index 4ac05a9e25bc..8006faaaf0ec 100644
>>> --- a/fs/ramfs/inode.c
>>> +++ b/fs/ramfs/inode.c
>>> @@ -102,11 +102,20 @@ ramfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>>>  	int error = -ENOSPC;
>>>  
>>>  	if (inode) {
>>> +		error = security_inode_init_security(inode, dir,
>>> +						     &dentry->d_name, NULL,
>>> +						     NULL);
>>> +		if (error) {
>>> +			iput(inode);
>>> +			goto out;
>>> +		}
>>> +
>>>  		d_instantiate(dentry, inode);
>>>  		dget(dentry);	/* Extra count - pin the dentry in core */
>>>  		error = 0;
>>>  		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
>>>  	}
>>> +out:
>>>  	return error;
>>>  }
>>>  
>>> @@ -134,6 +143,15 @@ static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>>>  	inode = ramfs_get_inode(dir->i_sb, dir, S_IFLNK|S_IRWXUGO, 0);
>>>  	if (inode) {
>>>  		int l = strlen(symname)+1;
>>> +
>>> +		error = security_inode_init_security(inode, dir,
>>> +						     &dentry->d_name, NULL,
>>> +						     NULL);
>>> +		if (error) {
>>> +			iput(inode);
>>> +			goto out;
>>> +		}
>>> +
>>>  		error = page_symlink(inode, symname, l);
>>>  		if (!error) {
>>>  			d_instantiate(dentry, inode);
>>> @@ -143,6 +161,7 @@ static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>>>  		} else
>>>  			iput(inode);
>>>  	}
>>> +out:
>>>  	return error;
>>>  }
>>>  
>>> @@ -150,12 +169,23 @@ static int ramfs_tmpfile(struct mnt_idmap *idmap,
>>>  			 struct inode *dir, struct file *file, umode_t mode)
>>>  {
>>>  	struct inode *inode;
>>> +	int error;
>>>  
>>>  	inode = ramfs_get_inode(dir->i_sb, dir, mode, 0);
>>>  	if (!inode)
>>>  		return -ENOSPC;
>>> +
>>> +	error = security_inode_init_security(inode, dir,
>>> +					     &file_dentry(file)->d_name, NULL,
>>> +					     NULL);
>>> +	if (error) {
>>> +		iput(inode);
>>> +		goto out;
>>> +	}
>>> +
>>>  	d_tmpfile(file, inode);
>>> -	return finish_open_simple(file, 0);
>>> +out:
>>> +	return finish_open_simple(file, error);
>>>  }
>>>  
>>>  static const struct inode_operations ramfs_dir_inode_operations = {
>>> -- 
>>> 2.34.1
>

