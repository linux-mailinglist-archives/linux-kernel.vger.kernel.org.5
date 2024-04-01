Return-Path: <linux-kernel+bounces-126946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6D88944C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AF81F21E69
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943864F897;
	Mon,  1 Apr 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fz2IdXVE"
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177934E1C4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711995886; cv=none; b=sKfMLV9OToRN2bfuFqnC+1Xqkzk1mnpXLwTgu0q/wami+LTJP4BDugtU1omYnlufMRhSDG3IQRsV4W6AiC1LOmct7aoi/+pYUEMbKyqH2o2VqLdTcqcCLXIOae9Z1YJ9k+d9J5xUdbGfy6WuH8AFyjeP0Q/819C9SMju/NOJ99U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711995886; c=relaxed/simple;
	bh=XOOIV5ilyW0MuQSVC0z+DgKWeZI3pG967UemRXsoU2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSJ1FUw/IhmMgQuojtggBAyR1xA+iPn3f6Brqd+M8Sb6zyMVG2YTia/qhm120xJOXe2rwxsCfHywvjHnfc2qjT93zvCYqhREN9I0WG6YzSLMs/UwqUFYiWSeBm4WfBYY1R+zDgIF16IlZ5kH0JRnSHKurWVls4p/wbcq86yCX8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fz2IdXVE; arc=none smtp.client-ip=66.163.190.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711995874; bh=SW4mOGHizrrhpGGd5Ht6sVTNq15ycVmhyEWxZETtcEw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fz2IdXVEzA7jDpzCkvQTb45Zs4GdL6KH34zLQOAsAuQzHHSI0wihHKmnI7fzVyHKScx+mNlCgv+2tERdNKxXZ8T/4toSjIjrSiCra2BaIAdXNG1Co05N9FvF2IVo/meEYKPQ/cDclgo14u+279uA1WCtdQKjM/T4/5RUpxnSWAt+FLtFlCbjfTlmq0dZRFCboS093wwbQiD9oucSq6V2VoI1VQm1tjv6SfE1jJnBsT1yZyl4aD2eL2+pFI8T3aBiSYkcs6PdqblFQ9AxU7HAKQNYRpD1awgyBX1xsnpUifGbNUWVFR8uMuT2T0rFEolSbaf5uHUKMXlWNfUBp6mrkQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711995874; bh=KyTGJ+ZMA5M8kWoejtunO9Qxl0y9odB2622v1WQtz+9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gLiQRSIFMOl27sRLTaX/EmhyQbsAghzoWm7f57IUyu/FTnBIQjMf7hHwNxPut1Xaz+02U7wJR7lG3QXJzazikRUgQN6XI2+G9JpuRF9ihYANLXKpVJ2+wd3PT3LwL/Hf9zjnjgj6k6d9zjzDUAotfIfkdZ0sUGT2cSqScsyiQ6b0RtCMFxVcKWYeMZvJnszr1JB2OVxXTme+gEN3e4jfVJgW99iv6QXgUiCIuwW1+1ZK+zkb8DaelRzTa8NQlIzMG8TktwKZCVxfIck+36Zx3ZJxj28BfHuINCKDB68lRwCoHJzaYAgaHTx0tY9PG1g2qvYwBfY7yM1CGAbtFyTivQ==
X-YMail-OSG: BHU6REYVM1mqwsMbLu_wnxHxf4rL2ezOl8xp91XJHfvoRe4cCDCsXUOnEzm.Mub
 MR1.OuqVAKnguxB_7OrP4iaNmgBNEbP7uOTc5Ju3OunPJrgABrJZ95UGcFXhwgLWybp.LiBU79Q2
 2M7WDE_EuUNTKoV8wooBFMqkoXGgjII3FlibwgAMz1MF3yaR4KKtJYxloB7Ehl1s8Aqi7nuIeMT1
 oUIkwbsdcY3dUAiukjSsfAkydR9o1_Lu_zq4CxqjGZTI_t_PC0wNzHbMmdNzQlqUiXFXa7pGA40Y
 M7IvEsaqxBA4BG9KpopmQ7enTuJ..RcgwfrAnO8qTQuNNbAMuDluAKGPTsCU9H6Xt172AQQuECFV
 oOTHdQKhnCv7q0IDIpW9GBC38mTYIcxklmji4ShOGtvIaJlTBgRCkjGmxkwa4gQIZ_F76Z.ctuHX
 eUIGDSF3aCl6oxX9JeYoqKtNPRc1LbSw4SJX9M1E8G9fkVY0CafZOgW4P1CWEWbjj73j_iDJmgSl
 0tKoLXCDfoCJptQhoKfmndWIlfZqOMx0yb7x6Qjyc5EpPUP3R.d0.4OY6JvJLDc8Ve77t9rQ08ye
 VkkNcmazJu4jh3z9yXbb7jfXAuA6oNMKd7rPJ5Gxf85SgFWsJSMTFsE2j5U8NaQeqOGC9k1rVF1S
 VNfNih1.Dg8vzjddZ74nYuggxItlhdjccDDQXWUD_urFm.ihfrqLViquatVDhWlJRPtcsG6t4rwc
 BSDt4PioB3mSB8uN6r7FL4jIU7ma8iT5jsTA5AlgfSxyh53YFC6asGYNYNYxHXPFA70kRTdXjdcV
 M4aNFqAfjm1NnJsXE4NWJUDqYENSMspGadLDmzKr9dyXjJO2ii_vS6VoXRXQ0FeLekX1lqBtz1AH
 dkkJLke9chxToAoBylV37p60yWDbun.J4R97MgTVrsmAJA7_gVA3CjCUkbeF2UjeN9yCe3ZgKjRi
 Fj77zOoI8FCIYsKco4.8hgstdUxYIXMrTg_J32L7MbTFS0h0dFatN09AS27yZucSM6Mk5ntoYLdN
 Hc1JSKcO7FY5r3Cudsh0d8pO7UGdsJxgdeKJFUtZlnUgH71m6LzKQ9yFrIQoPy_NyqIAvBDU5WrI
 9sazy4mSVF7pmtE6HoszBtWeJLwKUL2UwiYJ.nUtw45SpP.2OnlclLKOEifPX5EjvsBePcDKO211
 EsQ54QOcQUC4ocWr90twSOIicHEzxcOS5WJ8bK4hcXD6uIT.Fz6MiMcpvwaiZEQIUep91y.EXjWd
 s5scZuD6klDxJvvqOfkLVNTvWcq.r_GvThj.0rUOVgLV24dOKbLVwO3cQcIOjyiK2HegUbplnh0U
 1kKYrjEG0jC5wZuT9mbz5UOpcobYQonqeLZNxqdsGWNd9lRhbhc4WwgWVFQURK7zPkd8yMKCzltD
 d0E6GvcizQMc7foT3N.JXVQ8iL9wKtx08TQom.w1IZzMNPJCc8f3lXOx5GFuxSzw2kJxtM5rrqfq
 f.J1dm49XhGASrRigW9w7IkliP3HyG8VUdz4FM71YSvY9qFfxt5q08DBkKrBWUPsHNC3LclXruZd
 PHDFYXgPJ0lyXBb1vuxOOAmYImnjjGkIJjX0UmSuUVh.pw.6G0AaXdLMfCkkUubJDsAoZwIDyuM8
 _031ODuZN6R5l6SCPi7Lt8wyrAe8RH9Ohr2hrhSSb9PTSoT4EkywxpkNDsEMvnBWpxRxYv.Gor1o
 wdjzTmiqMcuaKvjeGUT2VcByt.G7RCe5J8cd2OYwn2g_cRoxWeSU4RFQeie0aPU.2YuLm6ZilpDD
 YWZA33Lzi3AK0eyVa0RXaXJVopZnnadzYyW0RU9o8j1xItrgL73IHatRXZiaLzAJ5liL4gvQGMsw
 23ZrdtHaAQ1JeAl_WVPoHRQzM.ptTo.Rs0tdqqOcO0oO5WlX_kjOLMeyBCrEyyw8sCRJ58CZl0TJ
 IukyLAP5kql79STonqKIkx0jILBPEzBbiLVPYKqR54E_Kq0CP6qfng4vqj6kDcdyZxqijB0IXa49
 KiADJnaqWONauDzKGEODDLgYZS7EqRwAg4IUsU1koeYv.UOadWdK83Z.KEd6sIcpJWAA9GkePpQz
 f9UBeqyIpdMX1pv0QUB8P5uD1rM.Tv50oA5ziIH6_GFI3Qxak6YIEYUXBxQH_vMr.tUPNGrWpG4O
 .1qSRbHHFLHE9kEe5o_K3gWOWeQwh3ZAl_NdrQgG.6naFPazMxHQZJpys5bLSGFkhj9ht_sWi0.f
 M0bvthUbIJ2Y_fRge0n2n6jSRdXwD8XuhGzuRFZEb2VD.ZmgEjkSsONlYXGhopQqFrOgwHo_drdM
 Tppe4hqpNPm0-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 53f46c91-1927-4182-8af2-ee0655788c8e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 1 Apr 2024 18:24:34 +0000
Received: by hermes--production-gq1-5c57879fdf-vxz7c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e71125633df39b7fb794152c3de03450;
          Mon, 01 Apr 2024 18:24:29 +0000 (UTC)
Message-ID: <fd838651-5b05-4c4c-a930-e86fd568bbc5@schaufler-ca.com>
Date: Mon, 1 Apr 2024 11:24:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] TSEM global declarations.
To: Greg Wettstein <greg@enjellic.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20240401105015.27614-1-greg@enjellic.com>
 <20240401105015.27614-4-greg@enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240401105015.27614-4-greg@enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/1/2024 3:50 AM, Greg Wettstein wrote:
> From: "Dr. Greg" <greg@enjellic.com>
>
> TSEM is designed, from a functional perspective, to be entirely contained in
> its own directory.
>
> TSEM uses a single global header file, tsem.h, to define the
> enumeration types, structure definitions and functions that are
> referenced across all of the compilation units that implement the
> LSM.

I've called out several things explicitly below. As a general comment,
you are keeping copies of data that you ought to be providing pointers to
in many instances. This is going to cause problems with kernel data size,
performance and data accuracy. Based on the form of data you're defining
I'm guessing your code is several times larger than it needs to be. As I
mentioned earlier, it's impossible to say for sure, given the separation
of data definition from code.

> ---
>  security/tsem/tsem.h | 2278 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 2278 insertions(+)
>  create mode 100644 security/tsem/tsem.h
>
> diff --git a/security/tsem/tsem.h b/security/tsem/tsem.h
> new file mode 100644
> index 000000000000..d1d3e847a550
> --- /dev/null
> +++ b/security/tsem/tsem.h
> @@ -0,0 +1,2278 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +/*
> + * Copyright (C) 2024 Enjellic Systems Development, LLC
> + * Author: Dr. Greg Wettstein <greg@enjellic.com>
> + *
> + * This is the single include file that documents all of the externally
> + * visible types and functions that are used by TSEM.  This file is
> + * currently organized into four major sections in the following order;
> + *
> + * includes used by all compilation units
> + * CPP definitions
> + * enumeration types
> + * structure definitions
> + * function declarations
> + * inline encapsulation functions.
> + *
> + * Include files that are referenced by more than a single compilation
> + * should be included in this file.  Includes that are needed to
> + * satisfy compilation requirements for only a single file should be
> + * included in the file needing that include.
> + *
> + * Understanding the overall implementation and architecture of TSEM
> + * will be facilitated by reviewing the documentation in this file.
> + */
> +
> +#include <linux/wait.h>
> +#include <linux/kref.h>
> +#include <linux/lsm_hooks.h>
> +#include <linux/capability.h>
> +#include <crypto/hash.h>
> +#include <crypto/hash_info.h>
> +#include <net/af_unix.h>
> +
> +/*
> + * The number of 'slots' in the structure magazines that are used to
> + * satisfy modeling of security events that are called in atomic context.
> + */
> +#define TSEM_ROOT_MAGAZINE_SIZE	128
> +#define TSEM_MAGAZINE_SIZE_INTERNAL 32
> +#define TSEM_MAGAZINE_SIZE_EXTERNAL 128
> +
> +/**
> + * enum tsem_event_type - Ordinal value for a security event.
> + * @TSEM_BPRM_COMMITTED_CREDS: Ordinal value for bprm_committed_creds.
> + * @TSEM_TASK_KILL: Ordinal value for task kill.
> + * @....: Remainder follows with a similar naming format that has
> + *        TSEM_ prep ended to the raw LSM security hook name.
> + * @TSEM_EVENT_CNT: The final ordinal value is used to define the
> + *		    length of the following arrays that are indexed
> + *		    by the ordinal value of the hook:
> + *
> + * This enumeration is used to designate an ordinal value for each
> + * security event, ie. LSM hook/event handler, that TSEM is
> + * implementing modeling for.  This value is used to identify the
> + * handler that is either having its event description being exported
> + * to an external trust orchestrator or modeled by the internal TMA
> + * implementation.
> + *
> + * The primary use of this enumeration is to conditionalize code paths
> + * based on the security hook being processed and to index the
> + * tsem_names array and the array that defines the action that is to
> + * be taken in response to an event that generates a permissions
> + * violation.
> + */
> +enum tsem_event_type {
> +	TSEM_BPRM_COMMITTING_CREDS = 1,
> +	TSEM_TASK_KILL,
> +	TSEM_TASK_SETPGID,
> +	TSEM_TASK_GETPGID,
> +	TSEM_TASK_GETSID,
> +	TSEM_TASK_SETNICE,
> +	TSEM_TASK_SETIOPRIO,
> +	TSEM_TASK_GETIOPRIO,
> +	TSEM_TASK_PRLIMIT,
> +	TSEM_TASK_SETRLIMIT,
> +	TSEM_TASK_SETSCHEDULER,
> +	TSEM_TASK_GETSCHEDULER,
> +	TSEM_TASK_PRCTL,
> +	TSEM_FILE_OPEN,
> +	TSEM_MMAP_FILE,
> +	TSEM_FILE_IOCTL,
> +	TSEM_FILE_LOCK,
> +	TSEM_FILE_FCNTL,
> +	TSEM_FILE_RECEIVE,
> +	TSEM_UNIX_STREAM_CONNECT,
> +	TSEM_UNIX_MAY_SEND,
> +	TSEM_SOCKET_CREATE,
> +	TSEM_SOCKET_CONNECT,
> +	TSEM_SOCKET_BIND,
> +	TSEM_SOCKET_ACCEPT,
> +	TSEM_SOCKET_LISTEN,
> +	TSEM_SOCKET_SOCKETPAIR,
> +	TSEM_SOCKET_SENDMSG,
> +	TSEM_SOCKET_RECVMSG,
> +	TSEM_SOCKET_GETSOCKNAME,
> +	TSEM_SOCKET_GETPEERNAME,
> +	TSEM_SOCKET_SETSOCKOPT,
> +	TSEM_SOCKET_SHUTDOWN,
> +	TSEM_PTRACE_TRACEME,
> +	TSEM_KERNEL_MODULE_REQUEST,
> +	TSEM_KERNEL_LOAD_DATA,
> +	TSEM_KERNEL_READ_FILE,
> +	TSEM_SB_MOUNT,
> +	TSEM_SB_UMOUNT,
> +	TSEM_SB_REMOUNT,
> +	TSEM_SB_PIVOTROOT,
> +	TSEM_SB_STATFS,
> +	TSEM_MOVE_MOUNT,
> +	TSEM_SHM_ASSOCIATE,
> +	TSEM_SHM_SHMCTL,
> +	TSEM_SHM_SHMAT,
> +	TSEM_SEM_ASSOCIATE,
> +	TSEM_SEM_SEMCTL,
> +	TSEM_SEM_SEMOP,
> +	TSEM_SYSLOG,
> +	TSEM_SETTIME,
> +	TSEM_QUOTACTL,
> +	TSEM_QUOTA_ON,
> +	TSEM_MSG_QUEUE_ASSOCIATE,
> +	TSEM_MSG_QUEUE_MSGCTL,
> +	TSEM_MSG_QUEUE_MSGSND,
> +	TSEM_MSG_QUEUE_MSGRCV,
> +	TSEM_IPC_PERMISSION,
> +	TSEM_KEY_ALLOC,
> +	TSEM_KEY_PERMISSION,
> +	TSEM_NETLINK_SEND,
> +	TSEM_INODE_CREATE,
> +	TSEM_INODE_LINK,
> +	TSEM_INODE_UNLINK,
> +	TSEM_INODE_SYMLINK,
> +	TSEM_INODE_MKDIR,
> +	TSEM_INODE_RMDIR,
> +	TSEM_INODE_MKNOD,
> +	TSEM_INODE_RENAME,
> +	TSEM_INODE_SETATTR,
> +	TSEM_INODE_GETATTR,
> +	TSEM_INODE_SETXATTR,
> +	TSEM_INODE_GETXATTR,
> +	TSEM_INODE_LISTXATTR,
> +	TSEM_INODE_REMOVEXATTR,
> +	TSEM_INODE_KILLPRIV,
> +	TSEM_TUN_DEV_CREATE,
> +	TSEM_TUN_DEV_ATTACH_QUEUE,
> +	TSEM_TUN_DEV_ATTACH,
> +	TSEM_TUN_DEV_OPEN,
> +	TSEM_BPF,
> +	TSEM_BPF_MAP,
> +	TSEM_BPF_PROG,
> +	TSEM_PTRACE_ACCESS_CHECK,
> +	TSEM_CAPABLE,
> +	TSEM_CAPGET,
> +	TSEM_CAPSET,
> +	TSEM_EVENT_CNT
> +};

This looks like a lurking maintenance problem for both TSEM
and the LSM infrastructure. New hooks are added regularly. Hooks
that have outlived their usefulness are routinely deleted. The
mount infrastructure rewrite is a good example of why there needs
to be flexibility in hook lifetimes.

You might consider generating this mapping in tsem_init() rather
than hard coding it. Alas, no easy way to do that comes to mind. :(

> +
> +/**
> + * enum tsem_action_type - Ordinal value for security responses.
> + * @TSEM_ACTION_LOG: Ordinal value to indicate that a security event
> + *		     that results in a model permissions violation
> + *		     should be logged.
> + * @TSEM_ACTION_EPERM: Ordinal value to indicate that a security event
> + *		       generating a model permissions violation should
> + *		       return -EPERM to the caller.
> + *
> + * This enumeration type is used to designate what type of action is
> + * to be taken when the processing of a security event hook results in
> + * a model violation.  The TSEM_ACTION_LOG and TSEM_ACTION_EPERM
> + * translate into the classical concepts of logging or enforcing
> + * actions used by other mandatory access control architectures.
> + */
> +enum tsem_action_type {
> +	TSEM_ACTION_LOG = 0,
> +	TSEM_ACTION_EPERM,
> +	TSEM_ACTION_CNT
> +};
> +
> +/**
> + * enum tsem_control_type - Ordinal values for TSEM control actions.
> + * @TSEM_CONTROL_INTERNAL: This ordinal value is set when the first
> + *			   word of an argument string written to the
> + *			   control file is the word 'internal'.  This
> + *			   designates that the security namespace will
> + *			   be modeled by the internal TMA.
> + * @TSEM_CONTROL_EXTERNAL: This ordinal value is set when the first
> + *			   word of an argument string written to the
> + *			   control file is the word 'external'.  This
> + *			   designates that the security namespace will
> + *			   be model by an external TMA.
> + * @TSEM_CONTROL_ENFORCE: This ordinal value is set when the word
> + *			  'enforce' is written to the control file.
> + *			  This indicates that model is to be placed
> + *			  in 'enforcing' mode and security events that
> + *			  result in model violations will return EPERM.
> + * @TSEM_CONTROL_SEAL: This ordinal value is set when the word 'seal'
> + *		       is written to the control file.  This indicates
> + *		       that the model for security domain will treat
> + *		       all security events that do not conform to the
> + *		       model as 'forensics' events.
> + * @TSEM_CONTROL_TRUSTED: This ordinal value is used when the first
> + *			  word of an argument string written to the
> + *			  control file is the word 'trusted'.  This
> + *			  is interpreted as a directive to set the
> + *			  trust status of the task that executed the
> + *			  security event to be trusted.
> + * @TSEM_CONTROL_UNTRUSTED: This ordinal value is used when the first
> + *			    word of an argument string written to the
> + *			    control file is the word 'untrusted'.
> + *			    This is interpreted as a directive to set
> + *			    the trust status of the task that executed
> + *			    the security event to be untrusted.
> + * @TSEM_CONTROL_MAP_STATE: This ordinal value is used when the first
> + *			    word of an argument string written to the
> + *			    control file is the word 'state'.  The
> + *			    argument to this directive will be an
> + *			    ASCII hexadecimally encoded string of the
> + *			    current model's digest size that will be
> + *			    treated as a security state point for
> + *			    inclusion in the security model for the
> + *			    security domain/namespace.
> + * @TSEM_CONTROL_MAP_PSEUDONYM: This ordinal value is used when the
> + *				first word of an argument string
> + *				written to the control file is the
> + *				word 'pseudonym'.  The argument to
> + *				this directive will be an ASCII
> + *				hexadecimally encoded string of the
> + *				current model's digest size that will
> + *				be treated as a pseudonym directive
> + *				for the security domain/namespace.
> + * TSEM_CONTROL_MAP_BASE: This ordinal value is used when the first
> + *			  word of an argument string written to the
> + *			  control file is the word 'base'.  The
> + *			  argument to this directive will be an ASCII
> + *			  hexadecimally encoded string of the current
> + *			  model's digest size that will be treated as
> + *			  the base value for the computation of the
> + *			  functional values (measurement and state) of
> + *			  the security domain/namespace.
> +
> + * This enumeration type is used to designate what type of control
> + * action is to be implemented when arguments are written to the TSEM
> + * control file (/sys/kernel/security/tsem/control).  The ordinal
> + * values govern the processing of the command and the interpretation
> + * of the rest of the command argument string.
> + */
> +enum tsem_control_type {
> +	TSEM_CONTROL_INTERNAL = 0,
> +	TSEM_CONTROL_EXTERNAL,
> +	TSEM_CONTROL_EXPORT,
> +	TSEM_CONTROL_ENFORCE,
> +	TSEM_CONTROL_SEAL,
> +	TSEM_CONTROL_TRUSTED,
> +	TSEM_CONTROL_UNTRUSTED,
> +	TSEM_CONTROL_MAP_STATE,
> +	TSEM_CONTROL_MAP_PSEUDONYM,
> +	TSEM_CONTROL_MAP_BASE
> +};
> +
> +/**
> + * enum tsem_ns_reference - Ordinal value for DAC namespace reference.
> + * @TSEM_NS_INITIAL: This ordinal value indicates that the uid/gid
> + *		     values should be interpreted against the initial
> + *		     user namespace.
> + * @TSEM_NS_CURRENT: This ordinal value indicates that the uid/gid
> + *		     values should be interpreted against the user
> + *		     namespace that is in effect for the process being
> + *		     modeled.
> + *
> + * This enumeration type is used to indicate what user namespace
> + * should be referenced when the uid/gid values are interpreted for
> + * the creation of either the COE or CELL identities.  The enumeration
> + * ordinal passed to the tsem_ns_create() function, to configure the
> + * security domain/namespace, is set by the nsref argument to either
> + * the 'internal' or 'external' control commands.
> + */
> +enum tsem_ns_reference {
> +	TSEM_NS_INITIAL = 1,
> +	TSEM_NS_CURRENT
> +};
> +
> +/**
> + * enum tsem_task_trust - Ordinal value describing task trust status.
> + * @TSEM_TASK_TRUSTED: This ordinal value indicates that the task has
> + *		       not executed a security event that has resulted
> + *		       in a security behavior not described by the
> + *		       security model the task is being governed by.
> + * @TSEM_TASK_UNTRUSTED: This ordinal value indicates that the task
> + *		          has requested the execution of a security event
> + *		          that resulted in a security behavior not
> + *		          permitted by the security model the task is
> + *		          being governed by.
> + * @TSEM_TASK_TRUST_PENDING: This ordinal value indicates that the setting
> + *			     of the task trust status is pending a response
> + *		             from an external TMA.

This formatting is hideous, not to mention inconsistent.

> + *
> + * This enumeration type is used to specify the three different trust
> + * states that a task can be in.  The trust status of a task is
> + * regulated by the trust_status member of struct tsem_task.  A task
> + * carrying the status of TSEM_TASK_TRUSTED means that it has
> + * not requested the execution of any security events that are
> + * inconsistent with the security model that the task is running in.
> + *
> + * If a task requests execution of a security event that is
> + * inconsistent with the security model it is operating in, and the
> + * domain is running in 'sealed' mode, the task trust status is set to
> + * TSEM_TASK_UNTRUSTED.  This value is 'sticky' in that it will be
> + * propagated to any child tasks that are spawned from an untrusted
> + * task.
> + *
> + * In the case of an externally modeled security domain/namespace, the
> + * task trust status cannot be determined until the modeling of the
> + * security event has been completed.  The tsem_export_event()
> + * function sets the trust status TSEM_TASK_TRUST_PENDING and then
> + * places the task into an interruptible sleep state.
> + *
> + * Only two events will cause the task to be removed from sleep state.
> + * Either the task is killed or a control message is written to the
> + * TSEM control file that specifies the trust status of the task.  See
> + * the description of the TSEM_CONTROL_TRUSTED and
> + * TSEM_CONTROL_UNTRUSTED enumeration types.
> + */
> +enum tsem_task_trust {
> +	TSEM_TASK_TRUSTED = 1,
> +	TSEM_TASK_UNTRUSTED = 2,
> +	TSEM_TASK_TRUST_PENDING = 4
> +};

Where's number 3? Surely you're not using an enum in bit mask operations.

> +
> +/**
> + * enum tsem_inode_state - Ordinal value for inode reference state.
> + * @TSEM_INODE_COLLECTING: This ordinal value indicates that the inode
> + *			   is being opened in order to compute the
> + *			   digest of the file.
> + * @TSEM_INODE_COLLECTED: This ordinal value indicates that the digest
> + *			  file for the contents of the file referenced
> + *			  by the inode has been collected and is
> + *			  available in the digest cache attached to
> + *			  the inode.
> + * @TSEM_INODE_CONTROL_PLANE: The associated inode represents a TSEM
> + *			       control plane file that should be
> + *			      bypassed for security tests such as
> + *			      the TSEM_FILE_OPEN event.
> + *
> + * This enumeration type is used to specify the status of the inode.
> + * The primary purpose of this enumeration is so that the recursive
> + * call to the TSEM_FILE_OPEN hook, caused by the kernel opening the
> + * file to compute the checksum, can be bypassed when the digest
> + * value of the file is being computed for inclusion in an event
> + * description.
> + *
> + * The state value of the inode is carried in struct tsem_inode and is
> + * set and interrogated by the event.c:add_file_digest() function.  If
> + * the status of the inode is TSEM_INODE_COLLECTED and the iversion of
> + * the inode is the same as it was at collection time, the cached
> + * value for the currently active namespace digest function is
> + * returned.
> + *
> + * If the test for the relevancy of the cached digest value fails the
> + * status of the inode is set to TSEM_INODE_COLLECTING.  The
> + * tsem_file_open() function will check the inode status when it is
> + * invoked by the integrity_kernel_read() function and if it is
> + * set to 'COLLECTING', a successful permissions check is returned so
> + * that the kernel can open the file and compute its digest.
> + *
> + * The TSEM_INODE_CONTROL_PLANE value is used to indicate that the
> + * attached inode is part of the TSEM control plane.  This allows
> + * security events referencing this inode to bypass event processing
> + * in order to avoid a 'Heisenberg deadlock' situation.
> + */
> +enum tsem_inode_state {
> +	TSEM_INODE_COLLECTING = 1,
> +	TSEM_INODE_COLLECTED,
> +	TSEM_INODE_CONTROL_PLANE
> +};
> +
> +/**
> + * struct tsem_task - TSEM task control structure.
> + * @tma_for_ns: The context identity number of the namespace that
> + *		the task has control over if any.
> + * @instance: The instance number of the task.  The global task
> + *	      instance number is incremented each time the
> + *	      bprm_committed_creds handler is invoked to compute the
> + *	      TASK_ID of a process.   This instance number represents
> + *	      the total number of unique instances of a specific body
> + *	      of executable code has been requested.
> + * @p_instance: The instance number of the parent process to the
> + *		process represented by an instance of this structure.
> + *		This value allows an execution heirarchy of executable
> + *		code to be established.
> + * @trust_status: The enumeration type that specifies the trust state of
> + *		  the process.
> + * @task_id: The TSEM task identity (TASK_ID) of the process.
> + * @p_task_id: The TASK_ID of the parent process to the process
> + *	       represented by an instance of this structure.
> + * @task_key: A security model specific digest value that is used to
> + *	      authenticate a task that is running as a trust
> + *	      orchestrator to a task that is under the control of the
> + *	      orchestrator.
> + * @context: A pointer to the tsem_context structure that defines the
> + *	     modeling context that the task is running under.
> +
> + * This structure is represents the TSEM security state of a task.  It
> + * is automatically created when the task control structure is
> + * allocated for the creation of a new task.
> + *
> + * The trust_status member of structure determines whether or not the
> + * task is in a condition to be trusted.  It represents whether or not
> + * the task has requested execution of a security event that is
> + * inconsistent with the security model that the task is running
> + * under.  Reference the tsem_trust_status enumeration type for more
> + * information on this member.  The trust status value is propagated
> + * to any child tasks that are spawned from a task.
> + *
> + * The value of task_id member is generated by the
> + * tsem_bprm_committed_creds() function that computes the task
> + * identity based TSEM TASK_ID generative function.  This task_id
> + * value is used in the computation of the security state point values
> + * in combination with the COE and CELL mappings for this event.
> + * The task_id digest creates security state points that are specific
> + * to the executable code that was used to initiate the task.
> + *
> + * The instance member of the structure is used to temporally
> + * disambiguate instances of the same task_id.  A single 64-bit
> + * counter is used to generate the instance.  This counter is
> + * incremented and assigned to the instance member of the structure
> + * at the same tame the TASK_ID value is computed.
> + *
> + * The task_key member holds the authentication key that will be used
> + * to authenticate a process that is requesting the ability to set the
> + * trust status of a process.  This value is generated for the task
> + * structure of the trust orchestrator when a security modeling
> + * namespace is created by the orchestrator.
> + *
> + * The context member of the structure contains a pointer to the
> + * tsem_context structure allocated when a security modeling namespace
> + * is created by the tsem_ns_create() function.  This structure will
> + * contain all of the information needed to define how the task is to
> + * have its security behavior modeled.
> + */
> +struct tsem_task {
> +	u64 tma_for_ns;
> +	u64 instance;
> +	u64 p_instance;
> +	enum tsem_task_trust trust_status;
> +	u8 task_id[HASH_MAX_DIGESTSIZE];
> +	u8 p_task_id[HASH_MAX_DIGESTSIZE];
> +	u8 task_key[HASH_MAX_DIGESTSIZE];
> +	struct tsem_context *context;
> +};
> +
> +/**
> + * struct tsem_context - TSEM modeling context description.
> + * @kref: Reference count for the context.
> + * @work: Work structure for asynchronous release of the context.
> + * @id: The index number of the context.
> + * @sealed: A status variable indicating whether or not the
> + *	    modeling context can be modified.
> + * @use_current_ns: Status variable indicating which user namespace
> + *		    should be used for resolution of uid/gid values.
> + *		    A true value indicates that the user namespace
> + *		    the process is running under should be used.
> + * @actions: An array of enum tsem_action_type variables indicating
> + *	     the type of response that should be returned in
> + *	     response to the modeling of a security event that
> + *	     is inconsistent with the model being used for the
> + *	     security context.
> + * @digestname: A pointer to a null-terminated buffer containing the
> + *		name of the digest function that is to be used for
> + *		this security context.
> + * @zero_digest: The digest value for a 'zero-length' digest value.
> + * @tfm: A pointer to the digest transformation structure that is to
> + *	 generate cryptographic checksums for the modeling context.
> + * @inode_mutex: The lock that protects the inode_list that tracks
> + *		 inodes created in the context of a security modeling
> + *		 namespace.
> + * @inode_list: The list of inodes created in a security modeling
> + *		namespace protected by the inode_mutex member of
> + *		this structure.
> + * @magazine_size: The number of struct tsem_event structures that
> + *		   are held in reserve for security event handlers that
> + *		   are called in atomic context.
> + * @magazine_lock: The spinlock that protects access to the event
> + *		   magazine.
> + * @magazine_index: The bitmap that is used to track the magazine slots
> + *		    that have been allocated.
> + * @ws: An array of work structures that are used to refill the event
> + *	magazine slots.
> + * @magazine: An array of pointers to tsem_event structures that are
> + *	      pre-allocated for security handlers that are called in
> + *	      atomic context.
> + * @model: If the modeling context is implemented with a kernel based
> + *	   trusted model agent this pointer will point to the struct
> + *	   tsem_model structure that maintains the state of the
> + *	   security model.
> + * @external: If the modeling context is implemented with an external
> + *	      modeling agent this pointer will point to the
> + *	      tsem_external structure that implements the interface to
> + *            the trust orchestrator that is managing the security
> + *	      modeling namespace represented by this structure.
> + *
> + * This structure is used to represent the state of a TSEM security
> + * modeling namespace.  A pointer to this structure is stored in the
> + * struct tsem_task structure.
> + *
> + * This structure is allocated by the tsem_ns_create() function in
> + * response to a TSEM control request.  This structure maintains all
> + * of the information that describes the security modeling namespace
> + * that is not specific to the type of namespace, ie. external or
> + * internal that is being implemented.
> + *
> + * The id member is a 64-bit counter that cannot feasibly be
> + * overflowed and that is incremented for each namespace that is
> + * created.  The root modeling namespace has a value of zero so the
> + * TSEM code uses a pattern of testing this value for non-zero status
> + * as an indication of whether or not the task is running in a
> + * subordinate modeling namespace.
> + *
> + * Each security modeling namespace can have an independent
> + * cryptographic digest function that is used as the compression
> + * function for generating the security coefficients, and other
> + * entities, that are used to model security events that occur in a
> + * namespace.  A single struct tfm is allocated for this digest
> + * function at the time that the tsem_context structure is created and
> + * is maintained in this structure for subsequent use during event
> + * processing.
> + *
> + * Each cryptographic digest function has a 'zero message' value that
> + * is the result of the initialization and closure of a hash function
> + * that has no other input.  This zero digest value is computed at the
> + * time of the creation of the array.  This digest value is returned
> + * for files with zero sizes, have pseudonyms declared for them or
> + * that reside on pseudo-filesystems.
> +
> + * The actions array contains a specification of how each security
> + * event should be handled in the event that a TMA detects a
> + * security event inconsistent with the model designated for the
> + * security modeling namespace.  This array allows the specification
> + * of whether the events should be enforcing or logging.
> + *
> + * Each security event that is processed requires a struct tsem_event
> + * structure that drives either the internal modeling of an event or
> + * its export to an external modeling agent.  Some security event
> + * hooks are called while a task is running in atomic context. Since
> + * memory cannot be allocated while a process is in atomic context, a
> + * magazine of these structures is maintained by this structure for
> + * security events that run in atomic context.  The size of this
> + * magazine is dynamic and is configurable for each security modeling
> + *
> + * When a tsem_event structure is allocated for an atomic event a
> + * request for the refill of the slot that is vacated is dispatched to
> + * an asynchronous workqueue.  The ws member of this structure points
> + * to an array of work structures for this refill capability, one for
> + * each slot in the magazine.
> + *
> + * All of this infrastructure is generic for each security modeling
> + * namespace.  How the security modeling is done is governed by the
> + * model and externally defined members of this structure.  These
> + * members point to data structures that either maintain the security
> + * model state for an in kernel trusted modeling agent or handle the
> + * export of the event to an external trust orchestrator.
> + *
> + * Each task that is created in a non-root security modeling namespace
> + * increments the reference count maintained in the kref member of
> + * this structure in the tsem_task_alloc() function.  The
> + * tsem_task_free() function decrements this reference count.  When
> + * the reference count expires, ie. when the last task using the
> + * modeling namespace exits, an asynchronous workqueue request is
> + * dispatched to dispose of the context.  The work member of this
> + * structure is used to reference that workqueue.
> + */
> +struct tsem_context {
> +	struct kref kref;
> +	struct work_struct work;
> +
> +	u64 id;
> +	bool sealed;
> +	bool use_current_ns;
> +
> +	enum tsem_action_type actions[TSEM_EVENT_CNT];
> +
> +	char *digestname;
> +	u8 zero_digest[HASH_MAX_DIGESTSIZE];
> +	struct crypto_shash *tfm;
> +
> +	struct mutex inode_mutex;
> +	struct list_head inode_list;
> +
> +	unsigned int magazine_size;
> +	spinlock_t magazine_lock;
> +	unsigned long *magazine_index;
> +	struct tsem_work *ws;
> +	struct tsem_event **magazine;
> +
> +	struct tsem_model *model;
> +	struct tsem_external *external;
> +};

I'm concerned about the number of locks you're maintaining.
I'm far from the world's expert on locking, but I see a whole
lot of potential for contention and conflict with existing
inode locking.

> +
> +/**
> + * struct tsem_model - TSEM internal TMA description.
> + * @have_aggregate: Flag variable to indicate whether or not the
> + *		    hardware aggregate value has been injected into
> + *		    the model.
> + * @base: The base value that is to be used in computing the
> + *	  security state coefficients for the model.
> + * @measurement: The time dependent linear extension state of the
> + *		 security state coefficients that have been
> + *		 experienced in the model.
> + * @state: The time independent functional description of the security
> + *	   model.
> + * @point_lock: The spinlock that protects access to the list of
> + *		security state coefficients in the model.
> + * @point_list: A pointer to the list of security state coefficients
> + *		in the model protected by the point_lock.
> + * @point_end_mutex: The mutex that is used to protect the end of the
> + *		     list of security state coefficients that will
> + *		     be exported.
> + * @point_end: A pointer to the end of the list of security state
> + *	       coefficients that will be traversed by a call to the
> + *	       control plane.
> + * @trajectory_lock: The spinlock used to protect the list of security
> + *		     event descriptions in the model.
> + * @trajectory_list: A pointer to the list of descriptions of the
> + *		     security events that have been recorded in this
> + *		     model.
> + * @trajectory_end_mutex: The mutex that protects the end of the list
> + *			  of security event descriptions.
> + * @trajectory_end: A pointer to the end of the list of security event
> + *		    descriptions that will be traversed by a call to
> + *		    the control plane.
> + * @forensics_lock: The spinlock used to protect the list of security
> + *		    event descriptions that are considered invalid by
> + *		    the model being enforced.
> + * @forensics_list: A pointer to the list of descriptions of security
> + *		    events that are considered invalid by the security
> + *		    model being enforced.
> + * @forensics_end_mutex: The mutex that protects the end of the list
> + *			 of security event descriptions that are
> + *			 considered invalid by the current model.
> + * @forensics_end: A pointer to the end of the list of security event
> + *		   descriptions, that are considered invalid, that are
> + *		   to be traversed by a call to the control plane.
> + * @pseudonym_mutex: The mutex lock that protects the list of file
> + *		     digest pseudonyms for the current model.
> + * @pseudonum_list: A pointer to the list of file digest pseudonyms
> + *		    that have been declared for the current model.
> + * @magazine_size: The number of struct tsem_event_point structures that
> + *		   are held in reserve for security event hooks that
> + *		   are called in atomic context.
> + * @magazine_lock: The spinlock that protects access to the event
> + *		   magazine for the security context.
> + * @magazine_index: The bitmap that is used to track the magazine slots
> + *		    that have been allocated.
> + * @ws: An array of work structures that are used to refill the magazine
> + *	slots.
> + * @magazine: An array of pointers to struct tsem_event_point structures that
> + *	      are pre-allocated for security hooks called in atomic
> + *	      context.
> + *
> + * If a call to the tsem_ns_create() function specifies that a kernel
> + * based trusted modeling agent is to be used to implement the
> + * security namespace model, a pointer to this structure is placed in
> + * the struct tsem_context structure.  This structure is used to
> + * maintain the state of the kernel based model.
> + *
> + * There are two primary functional values that are maintained by the
> + * model.  The measurement member of this structure represents the
> + * time dependent linear extension sum of the security state
> + * coefficients that have been assigned to security events that have
> + * occurred in the context of the model.  This is a measurement
> + * that has been classically maintained by a Trusted Platform Module.
> + *
> + * This classic integrity measurement is subject to scheduling
> + * dependencies and may be invariant from run to run of the model.  It
> + * is of primary use in verifying the order of security events that
> + * have occurred in the model.
> + *
> + * The state member of this structure represents a time independent
> + * linear extension sum of the security state coefficients that have
> + * been generated in the model.  It represents a functional value
> + * for the security state of the model being enforced.
> + *
> + * Both of these measurements are dependent on the platform hardware
> + * aggregate value and the base point that has been defined for the
> + * define.
> + *
> + * A non-NULL representation of the hardware aggregate value is only
> + * available if the platform has a TPM.  The have_aggregate member of
> + * this structure is a flag variable that indicates whether or not the
> + * aggregate value has been injected into the model.
> + *
> + * The base member of this structure contains a model specific
> + * coefficient that is used to perturb each security state coefficient
> + * generated in the model.  This value is designed to serve as a
> + * 'freshness' value for a verifying party to the model.
> + *
> + * There are three primary model lists maintain by this structure:
> + *
> + * * security state points
> + * * security trajectory events
> + * * security forensics events
> + *
> + * Similar members are maintained in this structure to support each of
> + * these lists.
> + *
> + * All three lists are extension only and are protected by a spinlock
> + * that can be held in atomic context.  This spinlock is only held for
> + * the period of time required to extend the list.
> + *
> + * Calls by the control plane to interrogate the lists require the
> + * traversal of the list that is ill-suited for a spinlock.  As a
> + * result each list type has a mutex associated with it that protects
> + * a pointer to the end of the list, an endpoint that is determined at
> + * the start of a call to the control plane.
> + *
> + * The list spinlock is used at the start of the control plane call to
> + * capture the end of the list that is then protected by the mutex.
> + * In essence this is used to transition protection of the list from
> + * the spinlock to the mutex.
> + *
> + * The kernel based modeling agent has support for maintaining a
> + * constant digest value for files, that by function, do not have a
> + * fixed digest value, such as log files or files residing on a
> + * pseudo-filesystem.  The pseudonym_list member of this structure
> + * points to the list of these designations.  The pseudonym_mutex
> + * structure protects this list.
> + *
> + * Like the struct tsem_context structure the tsem_model structure
> + * maintains a magazine of structures that are used to service
> + * security events that are called in atomic context.  The magazine
> + * maintained by this structure is a list of struct tsem_event_point
> + * structures that are used to describe the security state
> + * coefficients held by the model.
> + *
> + * The description of struct tsem_context details the implementation
> + * of the magazine which is identical to the implementation for this
> + * structure, with the exception of the type of structures that are
> + * held in reserve.
> + */
> +struct tsem_model {
> +	bool have_aggregate;
> +
> +	u8 base[HASH_MAX_DIGESTSIZE];
> +	u8 measurement[HASH_MAX_DIGESTSIZE];
> +	u8 state[HASH_MAX_DIGESTSIZE];
> +
> +	spinlock_t point_lock;
> +	struct list_head point_list;
> +	struct mutex point_end_mutex;
> +	struct list_head *point_end;
> +	unsigned int point_count;
> +
> +	spinlock_t trajectory_lock;
> +	struct list_head trajectory_list;
> +	struct mutex trajectory_end_mutex;
> +	struct list_head *trajectory_end;
> +
> +	spinlock_t forensics_lock;
> +	struct list_head forensics_list;
> +	struct mutex forensics_end_mutex;
> +	struct list_head *forensics_end;
> +
> +	struct mutex pseudonym_mutex;
> +	struct list_head pseudonym_list;
> +
> +	struct mutex mount_mutex;
> +	struct list_head mount_list;
> +
> +	unsigned int magazine_size;
> +	spinlock_t magazine_lock;
> +	unsigned long *magazine_index;
> +	struct tsem_work *ws;
> +	struct tsem_event_point **magazine;
> +};
> +
> +/**
> + * struct tsem_external - TSEM external TMA description.
> + * @export_only: A flag variable used to indicate that the security
> + *		 namespace is running in export only mode that
> + *		 simply presents the events to the external trust
> + *		 orchestrator.
> + * @export_lock: The spinlock that protects access to the export_list
> + *		 member of this structure.
> + * @export_list: A pointer to the list of events waiting to be
> + *		 exported to the trust orchestrator for the security
> + *		 modeling namespace.  The structure type that is
> + *		 linked by this list is the struct export_event
> + *		 structure that is private to the export.c compilation
> + *		 unit.
> + * @dentry: A pointer to the dentry describing the pseudo-file in the
> + *	    /sys/kernel/security/tsem/external_tma directory that is
> + *	    being used to export security event descriptions to the
> + *	    external trust orchestrator for the security modeling
> + *	    namespace.
> + * @have_event: A flag variable to indicate that is work queued
> + *		on the export pseudo-file for the security modeling
> + *		namespace.
> + * @wq: The work queue used to implement polling for the security
> + *	event export file.
> + * @magazine_size: The number of struct export_event structures that
> + *		   are held in reserve for security event hooks that
> + *		   are called in atomic context.
> + * @magazine_lock: The spinlock that protects access to the event
> + *		   magazine for the security modeling domain.
> + * @magazine_index: The bitmap that is used to track the magazine slots
> + *		    that have been allocated.
> + * @ws: An array of work structures that are used to refill the magazine
> + *	slots.
> + * @magazine: An array of pointers to struct export_event structures that
> + *	      are pre-allocated for security hooks called in atomic
> + *	      context.
> + *
> + * If an externally modeled security modeling namespace is created
> + * a structure of this type is allocated for the namespace and placed
> + * in the struct tsem_context structure.
> + *
> + * The primary purpose of this structure is to manage event
> + * descriptions that are being transmitted to the trust orchestrator
> + * associated with the security modeling namespace.  The pseudo-file
> + * will be as follows:
> + *
> + * /sys/kernel/security/tsem/external_tma/N
> + *
> + * Where N is the context id number of the modeling namespace.
> + *
> + * The dentry member of this structure is used to represent the
> + * pseudo-file that is created when the external modeled namespace is
> + * created.
> + *
> + * This list of events waiting to be received by the trust
> + * orchestrator is maintained in the export_list member of this
> + * structure.  Additions or removals from the list hold the spinlock
> + * described by the export_lock member of this structure.
> + *
> + * The wq member of this structure is used to implement a workqueue
> + * to support polling for events on the export control file.  The
> + * have_event flag is set to indicate to the polling call that
> + * security events are available for export.
> + *
> + * When a security event description is exported the calling task is
> + * scheduled away to allow the trust orchestrator to process the
> + * event.  This obviously creates issues for security events that are
> + * called in atomic context.
> + *
> + * Security events in atomic context are exported as an async_event
> + * rather than a simple event.  The trust orchestrator has the option
> + * of killing the workload that deviated from the security model or
> + * signaling a violation of the model.
> + *
> + * To support the export of asynchronous events, magazine
> + * infrastructure, similar to the event and model structure magazines,
> + * is maintained by this structure for the external modeling
> + * namespace.
> + */
> +struct tsem_external {
> +	bool export_only;
> +
> +	spinlock_t export_lock;
> +	struct list_head export_list;
> +	struct dentry *dentry;
> +	bool have_event;
> +	wait_queue_head_t wq;
> +
> +	unsigned int magazine_size;
> +	spinlock_t magazine_lock;
> +	unsigned long *magazine_index;
> +	struct tsem_work *ws;
> +	struct export_event **magazine;
> +};
> +
> +/**
> + * struct tsem_work - TSEM magazine refill work structure.
> + * @index: The index number of the slot in the structure magazine that
> + *	   is being refilled.
> + * @u: A union that holds pointers to the structure whose magazine is
> + *     being refilled.
> + * @work: The work structure that manages the workqueue being used to
> + *	  refill the magazine entry.
> + *
> + * As has been previously documented for the struct tsem_context,
> + * struct tsem_model and struct tsem_external structures, there is a
> + * need to maintain a magazine of these structures in order to allow
> + * the processing of security events that are called in atomic
> + * context.  An array of this structure type is embedded in each of
> + * those structures to manage the asynchronous refill of the slot in
> + * the magazine that was used to handle an atomic security event.
> + *
> + * The index member of this structure points to the slot in the
> + * magazine that this work item is referencing.
> + *
> + * The structure that the refill work is being done for is maintained
> + * in the respective structure pointer in the u member of this
> + * structure.
> + *
> + * The work member of this structure is used to reference the
> + * asynchronous work request that is being submitted for the refill.
> + */
> +struct tsem_work {
> +	unsigned int index;
> +	union {
> +		struct tsem_context *ctx;
> +		struct tsem_model *model;
> +		struct tsem_external *ext;
> +	} u;
> +	struct work_struct work;
> +};
> +
> +/**
> + * struct tsem_COE - TSEM context of execution definition structure.
> + * @uid: The numeric user identity that the COE is running with.
> + * @euid: The effective user identity that the COE is running with.
> + * @suid: The saved user identity possessed by the COE.
> + * @gid: The group identity that the COE is running with.
> + * @egid: The effective group identity that the COE possesses.
> + * @sgid: The saved group identity of the COE.
> + * @fsuid: The filesystem user identity that the COE is running with.
> + * @fsgid: The filesystem group identity that the COE is running with.
> + * @capeff: This union is used to implement access to the effective
> + *	    capability set the COE is running with.  The mask value
> + *	    is used to assign to the structure with the value member
> + *	    used to extract the 64 bit value for export and
> + *	    computation.
> + * @securebits: In a file capabilities implementation this value
> + *		specifies potential handling for process running with
> + *		a UID value of 0.
> + *
> + * A security state coefficient is computed from two primary entities:
> + * the COE and the CELL identities.  This structure is used to carry
> + * and encapsulate the characteristics of the context of execution
> + * (COE) that will be used to generate the COE identity.
> + *
> + * The numeric values for discretionary access controls, ie. uid, gid,
> + * are determined by which user namespace the security modeling
> + * namespace is configured to reference.  The reference will be either
> + * the initial user namespace or the user namespace that the context
> + * of execution is running in.  This reference can be set on a per
> + * security model namespace basis.
> + */
> +struct tsem_COE {
> +	uid_t uid;
> +	uid_t euid;
> +	uid_t suid;
> +
> +	gid_t gid;
> +	gid_t egid;
> +	gid_t sgid;
> +
> +	uid_t fsuid;
> +	gid_t fsgid;
> +
> +	union {
> +		kernel_cap_t mask;
> +		u64 value;
> +	} capeff;
> +
> +	unsigned int securebits;
> +};

Why do you need this? Can't you use a cred pointer instead?

> +
> +/**
> + * struct tsem_inode_cell - TSEM inode information.
> + * @uid: The numeric user identity assigned to the inode.
> + * @gid: The numeric group identity assigned to the inode.
> + * @mode: The discretionary access mode for the file.
> + * @s_magic: The magic number of the filesystem that the file resides
> + *	     in.
> + * @s_id: The name of the block device supporting the filesystem the
> + *	  inode is on.
> + * @s_uuid: The uuid of the filesystem that contains the inode.
> + *
> + * This structure defines the characteristics of an inode that is
> + * referenced by a security event.
> + */
> +struct tsem_inode_cell {
> +	uid_t uid;
> +	gid_t gid;
> +	umode_t mode;
> +	u32 s_magic;
> +	u8 s_id[32];
> +	u8 s_uuid[16];
> +};

.. and can't you use inode/file pointers?

> +
> +/**
> + * struct tsem_inode_entry - Reference to a directory inode with temp files.
> + * @list: List of directory inodes for a security modeling namespace
> + *	  that have had an inode created under the directory.
> + * @tsip: A pointer to the TSEM security description of a temporary
> + *	  file that was createdunder a directory entry.
> + *
> + * This structure is used to implement a list of directory inodes that
> + * have had temporary files created under them in a security modeling
> + * namespace.  This list is used to allow the instance identifiers
> + * for inodes to be removed when the security modeling namespace
> + * terminates or when the directory in which temporary files had been
> + * created is removed.
> + */
> +
> +struct tsem_inode_entry {
> +	struct list_head list;
> +	struct tsem_inode *tsip;
> +};
> +
> +/**
> + * struct tsem_inode_instance - Instance information for a created inode.
> + * @list: List of inode owners.
> + * @creator: The id number of the security modeling namespace that is
> + *	     creating an inode.
> + * @instance: The instance number of an inode being created under a
> + *	      given directory.
> + * @owner: The TASK_ID of the process creating the inode.
> + * @pathname: A pointer to allocated memory holding the null-terminated
> + *	      pathname for the inode.
> + *
> + * This structure is used to convey information about the owner and
> + * instance number of an inode created in a security modeling namespace.
> + *
> + * This structure serves three distinct purposes.
> + *
> + * A linked list of these structures is used to convey ownership and
> + * instance information about a created inode from the
> + * tsem_inode_create() function to the tsem_inode_init_security()
> + * function, so that this information can be attached to the inode via
> + * the tsem_inode structure.
> + *
> + * Secondly, a linked list of inode ownership information is
> + * maintained for inodes that are created in a security modeling
> + * namespace and used as mountpoints.  This list is maintained in the
> + * security model description for the namespace.  Since the inode that
> + * is 'covering' the mountpoint is different than the inode describing
> + * the directory created for the mountpoint, the ownership information
> + * for the inode needs to carried as a characteristic of the model.
> + *
> + * The final use of this structure is to track the instance numbers of
> + * an inode created by a TASK_ID.  This list is carried by the
> + * directory in which temporary files and directories are created.
> + *
> + */
> +struct tsem_inode_instance {
> +	struct list_head list;
> +
> +	u64 creator;
> +	u64 instance;
> +	u8 owner[HASH_MAX_DIGESTSIZE];
> +	char *pathname;
> +};
> +
> +/**
> + * struct tsem_path - TSEM path information.
> + * @created: A flag to indicate that the path was created in the
> + *	     context of the current security modeling namespace.
> + * @creator: The id of the security modeling namespace that created
> + *	     the path.
> + * @instance: The instance number of an inode that was created.
> + * @owner: The TASK_ID of the process that created the path.
> + * @dev: The device number that the filesystem is mounted on.
> + * @pathname: An allocated and null-terminated buffer containing the
> + *	      path from the root directory to the file.
> + *
> + * The tsem_path structure is used to carry information about the
> + * pathname and ownership of a filesystem object that is an argument
> + * to a security event handler.
> + */
> +struct tsem_path {
> +	bool created;
> +	u64 creator;
> +	u64 instance;
> +	u8 owner[HASH_MAX_DIGESTSIZE];
> +
> +	dev_t dev;
> +	char *pathname;
> +};
> +
> +/**
> + * struct tsem_dentry - TSEM dentry definition.
> + * @have_inode: A flag variable to indicate that the dentry has an
> + *		inode associated with it.
> + * @inode: The TSEM characteristics of the inode associated with a dentry.
> + * @path: The path definition for the dentry.
> + *
> + * This structure is used to contain the TSEM representation of a
> + * dentry.
> + */
> +struct tsem_dentry {
> +	bool have_inode;
> +	struct tsem_inode_cell inode;
> +	struct tsem_path path;
> +};
> +
> +/**
> + * struct tsem_inode_args - Arguments for inode security handlers.
> + * @mode: The access mode requested for an inode being created.
> + * @dev: For the inode_mknod handler, the device specification for
> + *	 device node being created.
> + * @in.old_name: In the case of the tsem_inode_symlink handler, this
> + *		 member contains a pointer to the filename of the target
> + *		 of the symbolic link.
> + * @in.dir: For handlers processing rename or movement of an inode,
> + *	    the inode of the directory that contains the inode to be moved.
> + * @in.new_dir: For handlers processing the rename or movement of an
> + *		inode, the inode of the directory that will contain
> + *		the destination inode.
> + * @in.dentry: The dentry argument to inode event handlers that take
> + *	       a dentry.
> + * @in.new_dentry: In the case of handlers that result in a new dentry
> + *		   a pointer to that dentry.
> + * @out.old_name: In the case of the tsem_inode_symlink handler this
> + *		  member contains a pointer to a copy of the name of
> + *		  the target of symbolic link.  This second
> + *		  representation is used to avoid warnings about the
> + *		  use of a constant character pointer in the arguments
> + *		  to the handler.
> + * @out.dir: The TSEM representation of the inode representing a directory
> + *	     that the security handler is acting on.
> + * @out.new_dir: For inode movements or renames, the TSEM representation
> + *		 of the new_dir argument.
> + * @out.dentry: The TSEM representation of the dentry argument to a
> + *		security handler.
> + * @out.new_dentry: For inode movements or renames, the
> + *		    representation of the new location of the inode.
> + *
> + * This structure is used to carry input parameters and their
> + * retained and translated TSEM equivalent for LSM security handlers
> + * that are acting on inodes and/or dentries.
> + */
> +struct tsem_inode_args {
> +	umode_t mode;
> +	dev_t dev;
> +
> +	union {
> +		struct {
> +			const char *old_name;
> +			struct inode *dir;
> +			struct inode *new_dir;
> +			struct dentry *dentry;
> +			struct dentry *new_dentry;
> +		} in;
> +
> +		struct {
> +			char *old_name;
> +			struct tsem_inode_cell dir;
> +			struct tsem_inode_cell new_dir;
> +			struct tsem_dentry dentry;
> +			struct tsem_dentry new_dentry;
> +		} out;
> +	};
> +};
> +
> +/**
> + * struct tsem_file_args - TSEM file argument description.
> + * @cmd: The command argument for security handlers that take a
> + *       command type arguement, ie. file_ioctl, file_fcntl, file_lock
> + *	 handlers.
> + * @in.pseudo_file: A flag indicating that the file was on a
> + *		    pseudo-filesystem and will not have a digest value.
> + * @in.file: A structure to the file that will be modeled.
> + * @out.path: The TSEM representation of the pathname to a file.
> + * @out.inode: The TSEM representation of the inode that backs a file
> + *	       description
> + * @out.flags: The flags value from the file structure.
> + * @out.digest: The cryptographic checksum of the contents of the file.
> + *
> + * This structure is used to carry the input file description and
> + * their TSEM retention values for security event handles that are
> + * provided with a struct file pointer.
> + */
> +struct tsem_file_args {
> +	unsigned int cmd;
> +
> +	union {
> +		struct {
> +			bool pseudo_file;
> +			struct file *file;
> +		} in;
> +
> +		struct {
> +			struct tsem_path path;
> +			struct tsem_inode_cell inode;
> +			unsigned int flags;
> +			u8 digest[HASH_MAX_DIGESTSIZE];
> +		} out;
> +
> +	};
> +};
> +
> +/**
> + * struct tsem_mmap_file_args - TSEM memory mapping arguments.
> + * @anonymous: A flag variable to indicate whether or not the mapping
> + *	       is file backed or anonymous.
> + * @file: If the handler is being called for a file backed mapping this
> + *	  structure will be populated with the TSEM description of the
> + *	  file.
> + * @prot: The protections that are being requested for the mapping.
> + * @flags: The control flags to the memory mapping call.
> + *
> + * This structure is used to encapsulate the arguments provided to the
> + * tsem_mmap_file security event handler.  The anonymous member of
> + * this structure is used internally by TSEM to indicate that the
> + * file pointer to the call was NULL, thus indicating that the mapping
> + * is for anonymous memory.
> + */
> +struct tsem_mmap_file_args {
> +	u32 anonymous;
> +	struct tsem_file_args file;
> +	u32 prot;
> +	u32 flags;
> +};
> +
> +/**
> + * struct tsem_socket - TSEM socket information
> + * @family: The family name of the socket whose creation is being
> + *	    requested.
> + * @type: The type of the socket being created.
> + * @protocol: The protocol family of the socket being created.
> + * @kern: A flag variable to indicate whether or not the socket being
> + *	  created is kernel or userspace based.
> + * @owner: The TASK_ID of the task that created the socket.
> + *
> + * This structure is used to encapsulate socket information for
> + * security handlers that take a socket description as an argument.
> + */
> +struct tsem_socket {
> +	int family;
> +	int type;
> +	int protocol;
> +	int kern;
> +	u8 owner[HASH_MAX_DIGESTSIZE];
> +};

.. and for most of what you have here it looks like you're
duplicating information you can point to.

> +
> +/**
> + * struct tsem_socket_args - TSEM socket arguments
> + * @value: Possible numeric values passed to event handlers.
> + * @optname: The option name for the tsem_socket_setsockopt call.
> + * @in.socka: A pointer to the socket argument of a security handler.
> + * @in.sockb: A pointer to a second socket argument that may be supplied
> + *	      to the handler.
> + * @in.addr: In the case of handlers that accept an address
> + *	     description a pointer to that description.
> + * @out.socka: The TSEM representation of the first socket argument.
> + * @out.sockb: The TSEM representation of the second socket argument.
> + * @out.have_addr: A boolean flag used to indicate that either the
> + *		   ipv6 or ipv6 union members have been populated.
> + * @out.ipv4: The IPV4 address of an AF_INET socket.
> + * @out.ipv6: The IPV6 address of an AF_INET6 socket.
> + * @out.path: The path of an AF_UNIX socket.
> + * @out.mapping: The checksum of the socket address if the socket type
> + *		 is other than AF_INET, AF_INET6 or AF_UNIX.
> + *
> + * This structure is used to maintain arguments provided to LSM
> + * hooks that handle generic socket security events.
> + */
> +struct tsem_socket_args {
> +	int value;
> +	int optname;
> +
> +	union {
> +		struct {
> +			struct sock *socka;
> +			struct sock *sockb;
> +			void *addr;
> +		} in;
> +
> +		struct {
> +			struct tsem_socket socka;
> +			struct tsem_socket sockb;
> +			bool have_addr;
> +			union {
> +				struct sockaddr_in ipv4;
> +				struct sockaddr_in6 ipv6;
> +				char path[UNIX_PATH_MAX + 1];
> +				u8 mapping[HASH_MAX_DIGESTSIZE];
> +			};
> +		} out;
> +	};
> +};
> +
> +/**
> + * struct tsem_netlink_args - TSEM netlink event parameters
> + * @in.sock: The sock argument to the LSM event handler.
> + * @in.parms: The pointer to the netlink parameters from the sk_buff
> + *	      structure that was passed to the LSM hook.
> + * @out.sock: The TSEM representation of the sock argument.
> + * @out.uid: The UID, in the TSEM designated namespace of the uid in
> + *	     the netlink control block.
> + * @out.gid: THE GID, in the TSEM designated namespace of the gid in
> + *	     the netlink control block.
> + * @out.portid: The portid member of the netlink_skb_parms structure.
> + * @out.dst_group: The dst_group member of the netlink_skb_parms structure.
> + * @out.flags: The flags member of the netlink_skb_parms structure.
> + * @nsid_set: The nsid_set flag member of the netlink_skb_parms structure.
> + * @nsid: The nsid member of the netlink_skb_parms structure.
> + *
> + * This structure is used to encapsulate and retain the arguments
> + * provided to the tsem_netlink_send event handler.
> + *
> + */
> +struct tsem_netlink_args {
> +	union {
> +		struct {
> +			struct sock *sock;
> +			struct netlink_skb_parms *parms;
> +		} in;
> +
> +		struct {
> +			struct tsem_socket sock;
> +			uid_t uid;
> +			gid_t gid;
> +			__u32 portid;
> +			__u32 dst_group;
> +			__u32 flags;
> +			bool nsid_set;
> +			int nsid;
> +		} out;
> +	};
> +};
> +
> +/**
> + * struct tsem_sb_args - TSEM parameters for superblock security events.
> + * flags: An integer value that was a component of the LSM argument
> + *	  for the sb_mount, sb_umount, sb_remount handlers.
> + * @in.sb: For the sb_remount handler the pointer to the superblock
> + *	   argument passed to the caller.
> + * @in.dentry: An incoming dentry argument.
> + * @in.dev_name: The name of the device to be used for the sb_mount
> + *		 command.
> + * @in.path: The path argument passed to the sb_mount commands.
> + * @in.type: A character pointer to the filesystem type being processed
> + *	     by the superblock security handlers.
> + * @in.path2: The second path argument passed to the move_mount and
> + *	      sb_pivotroot security handlers.
> + * @out.dentry: The TSEM representation of the dentry argument to the
> + *		handler.
> + * @out.inode: The TSEM representation of the inode backing the dentry
> + *	       argument to an LSM handler.
> + * @out.path: The TSEM representation of the incoming path argument.
> + * @out.dev_name: A an allocated copy of the dev_name argument.
> + * @out.type: A allocated copy of the filesystem type.
> + * @out.path2: The TSEM representation of the second path argument if
> + *	       used.
> + *
> + * This structure is used to encapsulate and retain the arguments for
> + * the family of security event handlers that deal with superblocks.  The
> + * list of these handlers is as follows:
> + *
> + * tsem_sb_mount
> + * tsem_sb_umount
> + * tsem_sb_remount
> + * tsem_move_mount
> + * tsem_sb_statfs
> + */
> +struct tsem_sb_args {
> +	unsigned long flags;
> +
> +	union {
> +		struct {
> +			struct super_block *sb;
> +			struct dentry *dentry;
> +			const char *dev_name;
> +			const char *type;
> +			const struct path *path;
> +			const struct path *path2;
> +		} in;
> +
> +		struct {
> +			struct tsem_dentry dentry;
> +			char *dev_name;
> +			char *type;
> +			struct tsem_path path;
> +			struct tsem_path path2;
> +		} out;
> +	};
> +};
> +
> +/**
> + * struct tsem_task_kill_args - TSEM task kill arguments.
> + * @u.value: The signed representation of an integer argument.
> + * @u.resource: The unsigned representation of an integer argument.
> + * @cur: The current resource limit for a task_setrlimit call.
> + * @max: The maximum resource limit for a task_setrlimit call.
> + * @cross_model: A flag variable used to indicate whether or not the
> + *		 signal is originating from a security modeling
> + *		 namespace other than the namespace of the target process.
> + * @signal: The number of the signal being sent.
> + * @source: The task identifier of the process sending the signal
> + * @target: The task identifier of the target process.
> + *
> + * This structure is used to encapsulate and retain the arguments
> + * provided to the tsem_task_kill security event handler.
> + *
> + */
> +struct tsem_task_kill_args {
> +	union {
> +		int value;
> +		unsigned int resource;
> +	} u;
> +	u64 cur;
> +	u64 max;
> +	u32 cross_model;
> +	u32 signal;
> +	u8 source[HASH_MAX_DIGESTSIZE];
> +	u8 target[HASH_MAX_DIGESTSIZE];
> +};
> +
> +/**
> + * struct tsem_task_prlimit_args - TSEM task prlimit arguments.
> + * @flags: The flag variable passed to the LSM handler.
> + * @in.cred: The cred pointer passed to the handler.
> + * @in.tcred: The tcred pointer passed to the handler.
> + * @out.cred: The TSEM representation of the in.cred pointer.
> + * @out.tcred: The TSEM representation of the in.tcred pointer.
> + *
> + * This structure is used to hold and retain the arguments provided to
> + * the tsem_task_prlimit security event handler.
> + */
> +struct tsem_task_prlimit_args {
> +	unsigned int flags;
> +
> +	union {
> +		struct {
> +			const struct cred *cred;
> +			const struct cred *tcred;
> +
> +		} in;
> +
> +		struct {
> +			struct tsem_COE cred;
> +			struct tsem_COE tcred;
> +		} out;
> +
> +	};
> +};
> +
> +/**
> + * struct tsem_task_prctl - TSEM task prctl arguments.
> + * @option: The first argument to the task_prctl LSM handler
> + *	    specifying the command to be executed.
> + * @arg2: The first argument to the handler.
> + * @arg3: The second argument to the handler.
> + * @arg4: The third argument to the handler.
> + * @arg5: The fourth and final argument to the handler.
> + *
> + * This structure is used to encapsulate the arguments provided to the
> + * tsem_task_prctl security event handler.  The argument model is to
> + * specify the 'option' value which is the kernel prctl call that is
> + * to be executed.  The remaining positional arguments are without
> + * specific format and are designed to be interpreted by the prctl
> + * system call based on the command specified.
> + */
> +struct tsem_task_prctl_args {
> +	int option;
> +	unsigned long arg2;
> +	unsigned long arg3;
> +	unsigned long arg4;
> +	unsigned long arg5;
> +};
> +
> +/**
> + * struct tsem_inode_attr_args - TSEM inode manipulation arguments.
> + * @in.path: In the case of the inode_getattr call the path to the
> + *	     inode being referenced.
> + * @in.dentry: In the case of the inode_setattr call the dentry that
> + *	       whose characteristics will be set.
> + * @in.iattr: A pointer to the iattr structure that was passed to the
> + *	      inode_setattr handler.
> + * @out.dentry: A TSEM dentry definition structure that will retain
> + *		the description of either a dentry or path argument
> + *		to a security handler.
> + * @out.valid: The ia_valid member from the iattr structure passed to the
> + *	       inode_setattr handler
> + * @out.mode: The ia_mode member from the iattr structure passed to the
> + *	      inode_setattr handler.
> + * @out.uid: The ia_uid member from the iattr structure passed to the
> + *	     inode_setattr handler.
> + * @out.gid: The ia_gid member from the iattr structure passed to the
> + *	     inode_setattr handler.
> + *	     hook.
> + * @out.size: The ia_size member from the iattr structure passed to the
> + *	      inode_setattr handler.
> + *
> + * This structure is used to encapsulate information on the arguments
> + * passed to the inode_getattr and inode_setattr LSM handler.  The in
> + * structure is used to hold the arguments passed that were passed to
> + * the handlers.  Argument information that is to be held for the life
> + * of the event description are in the out structure.
> + */
> +struct tsem_inode_attr_args {
> +	union {
> +		struct {
> +			const struct path *path;
> +			struct dentry *dentry;
> +			struct iattr *iattr;
> +		} in;
> +
> +		struct {
> +			struct tsem_dentry dentry;
> +			unsigned int valid;
> +			umode_t mode;
> +			uid_t uid;
> +			gid_t gid;
> +			loff_t size;
> +		} out;
> +	};
> +};
> +
> +/**
> + * struct tsem_inode_xattr_args - TSEM extended attribute arguments.
> + * @in.dentry: A pointer to the backing inode for the dentry that was
> + *	       passed to the LSM hook.  The relevant values from the inode
> + *	       will be copied into the tsem_file structure.
> + * @in.name: A pointer to the name of the extended attribute being
> + *	     queried.
> + * @in.size: The size of an extended attribute that may be set.
> + * @in.flags: The flag value specifying how an extended attributte is
> + *	      to be set.
> + * @out.dentry: The TSEM representation of the path that is being
> + *		action on.
> + * @out.name: The name of an attribute to be set or retrieved.
> + * @out.value: The binary value of the extended attribute that was
> + *	       passed to the inode_setxattr handler.  For an
> + *	       internally modeled namespace this value will be freed
> + *	       after the coefficient for the event is mapped.
> + * @out.encoded_value: The Base64 encoding of the extended attribute
> + *		       value that is used for either the export of
> + *		       the event or the trajectory history.  This
> + *		       memory will be allocated in order to support
> + *		       encoding of the attribute.
> + * @out.size: The size of the att
> + * @out.flags: The flags value that was passed to the inode_setxattr
> + *	       handler.
> + *
> + * This structure is used to encapsulate information on the arguments
> + * passed to the LSM hooks that manipulate extended attributes.  The
> + * in structure is used to hold the pointers to the arguments passed
> + * to the LSM hook while the out structure holds the arguments in
> + * converted form that will be held for the lifetime of the modeling
> + * namespace.
> + */
> +struct tsem_inode_xattr_args {
> +	union {
> +		struct {
> +			struct dentry *dentry;
> +			const char *name;
> +			const void *value;
> +			size_t size;
> +			int flags;
> +		} in;
> +
> +		struct {
> +			struct tsem_dentry dentry;
> +			char *name;
> +			char *value;
> +			char *encoded_value;
> +			size_t size;
> +			int flags;
> +		} out;
> +	};
> +};
> +
> +/**
> + * struct tsem_kernel_args - TSEM event descriptions for kernel requests.
> + * @id: For the tsem_kernel_load_data handler the indicator of the type
> + *     of data being requested.
> + * @contents: The boolean flag used to indicate whether or not the
> + *           security_kernel_post_load_data handler should be called.
> + * @in.file: A pointer to the file structure passwd to the
> + *	     tsem_kernel_file_file handler.
> + * @in.kmod_name: A pointer to the buffer containing the name of the
> + *		   module to load.
> + * @out.kmod_name: The retained copy of the kernel module name.
> + * @out.file: The TSEM representation of the file structure that was
> + *	      passed to the tsem_kernel_read_file handler.
> + *
> + * This structure is used to encapsulate information on the arguments
> + * passed to the following LSM hook handlers:
> + *
> + * tsem_kernel_module_request
> + * tsem_kernel_load_data
> + * tsem_kernel_read_file
> + */
> +struct tsem_kernel_args {
> +	enum kernel_load_data_id id;
> +	bool contents;
> +
> +	union {
> +		struct {
> +			struct file *file;
> +			char *kmod_name;
> +		} in;
> +
> +		struct {
> +			char *kmod_name;
> +			struct tsem_file_args file;
> +		} out;
> +	};
> +};
> +
> +/**
> + * struct tsem_time_args - TSEM event description for setting the time
> + * @have_ts: A flag variable to indicate if the time in seconds and
> + *	     nanoseconds is valid.
> + * @seconds: The number of seconds passed to the time set function.
> + * @nsecs: The number of nanoseconds to set the time to.
> + * @have_tz: A flag variable to indicate if the timezone information
> + *	     is valid.
> + * @minuteswest: The minutes west of GMT for the time being set.
> + * @dsttime: The daylight savings time offset.
> + *
> + * This structure is a simple encapsulation of the arguments passed to
> + * the TSEM_SETTIME handler.
> + */
> +struct tsem_time_args {
> +	bool have_ts;
> +	long seconds;
> +	long nsecs;
> +
> +	bool have_tz;
> +	int minuteswest;
> +	int dsttime;
> +};
> +
> +/**
> + * struct tsem_quota_args - TSEM arguments for quota security management.
> + * @cmds: The cmds argument from the security_quotactl handler.
> + * @type: The type argument from the security_quotactl handler.
> + * @id: The id argument from the security_quotactl handler.
> + * @in.dentry: In the case of the quota_on LSM handler the dentry
> + *	       argument to the handler.
> + * @in.sb: The superblock pointer argument from the security_quotactl handler.
> + * @out.dentry: The TSEM dentry representation of a dentry arguement
> + *		to the quota handlers.
> + * @out.s_flags: In the case of the quotactl handler the flags from
> + *		 the superblock of the filesystem.
> + * @out.fstype: In the case of the quotactl handler the filesystem
> + *		type of the mountpoint.
> + *
> + * This structure is an encapsulation of the arguments and their
> + * retention values for the LSM security handlers that make security
> + * decisions relevant to filesystem quota manipulation.
> + */
> +struct tsem_quota_args {
> +	int cmds;
> +	int type;
> +	int id;
> +
> +	union {
> +		struct {
> +			struct dentry *dentry;
> +			const struct super_block *sb;
> +		} in;
> +
> +		struct {
> +			struct tsem_dentry dentry;
> +			unsigned long s_flags;
> +			char *fstype;
> +		} out;
> +	};
> +};
> +
> +/**
> + * struct tsem_key_args - TSEM key handler arguments.
> + * @flags: The flags value passed to the key_alloc handler.
> + * @in.cred: A pointer to the credential structures passed to the
> + *	     security handlers.
> + * @out.possessed: A flag variable indicating if a key is owned by a
> + *		  task.
> + * @out.uid: The owner id of a key.
> + * @out.gid: The group id of a key.
> + * @out.flags: The flags value retained for a key operation.
> + * @out.cred: The retained  credentials of a process attempting to
> + *	      access a key.
> + * @out.perm: The retained permissions value of a key.
> + *
> + * This structure is used to hold the arguments to the LSM hooks that
> + * handle key security event and their retained TSEM equivalents.
> + */
> +struct tsem_key_args {
> +	unsigned long flags;
> +
> +	union {
> +		struct {
> +			key_ref_t ref;
> +			const struct cred *cred;
> +
> +		} in;
> +
> +		struct {
> +			bool possessed;
> +			uid_t uid;
> +			gid_t gid;
> +			unsigned long flags;
> +			struct tsem_COE cred;
> +			u32 perm;
> +		} out;
> +
> +	};
> +};
> +
> +/**
> + * struct tsem_bpf_args - TSEM bpf security handler arguments.
> + * @bpf.cmd: For the security_bpf LSM handler the command number passed
> + *	     the event handler.
> + * @bpf.size: For the security_bpf LSM handler the size argument passed
> + *	      to the event handler.
> + * @prog.type: For the security_bpf_prog LSM handler the type member of
> + *	       the bpf_prog structure passed to the event handler.
> + * @prog.attach_type: For the security_bpf LSM handler the attach_type
> + *		      member of the bpf_prog structure passed to the
> + *		      event handler.
> + * @map.map_type: For the security_map LSM handler the map_type member
> + *		  of the bpf_map structure passed to the event handler.
> + * @map.fmode: For the security_map LSM handler the fmode argument passed
> + *	       to the event handler.
> +
> + * This structure is used to hold the arguments to the various LSM
> + * hooks that handle BPF security management.  This structure is a
> + * union over structures for each of the TSEM bpf handlers.
> + */
> +struct tsem_bpf_args {
> +	union {
> +		struct {
> +			int cmd;
> +			unsigned int size;
> +		} bpf;
> +
> +		struct {
> +			int type;
> +			int attach_type;
> +		} prog;
> +
> +		struct {
> +			int map_type;
> +			fmode_t fmode;
> +		} map;
> +	};
> +};
> +
> +/**
> + * struct tsem_ipc_perm - TSEM retained members of an IPC permission
> + *			  structure.
> + * @uid: The uid member of the IPC permission structure translated into
> + *	 the namespace reference for the modeling namespace.
> + * @gid: The gid member of the IPC permission structure translated into
> + *	 the namespace reference for the modeling namespace.
> + * @cuid: The cuid member of the IPC permission structure translated
> + *	  into the namespace reference for the modeling namespace.
> + * @cgid: The cgid member of the IPC permission structure translated
> + *	  into the namespace reference for the modeling namespace.
> + * @mode: The mode member of the IPC permission structure.
> + *
> + * This structure is used to hold the translated values from a
> + * kern_ipc_perm structure that is passed to one of the LSM IPC
> + * shared memory security handlers.
> + */
> +struct tsem_ipc_perm {
> +	uid_t uid;
> +	gid_t gid;
> +	uid_t cuid;
> +	gid_t cgid;
> +	umode_t mode;
> +};
> +
> +/**
> + * struct tsem_ipc_args - TSEM arguments for IPC security handlers.
> + * @perm_flag: For the tsem_ipc_permission handler the permission flag.
> + * @value: A signed integer value that serves as an argument type to
> + *	   a number of the handlers.
> + * @nsops: In the came of the tsem_sem_semop handler the nsops argument
> + *	   to the handler.
> + * @type: The type argument to the msg_queue_msgrcv handler.
> + * @in.perm: The kern_ipc_perm structure that is passed to multiple
> + *	     handlers that define the permissions for the IPC
> + *	     object whose security status is being checked.
> + * @in.target: For the msg_queue_msgrc handler the TASK_ID of the
> + *	       process ending the message.
> + * @out.perm: The TSEM translated versions of the perm pointer that
> + *	      was passed to a handler.
> + * @out.owner: The TASK_ID of the task that created the IPC resource.
> + * @out.target: The retained version of the TASK_ID describing the
> + *		sender of a message.
> + *
> + * This structure is an encapsulation of the arguments and their
> + * retention values for the LSM security handlers that make security
> + * decisions relevant to IPC objects.
> + */
> +struct tsem_ipc_args {
> +	short perm_flag;
> +	int value;
> +	unsigned int nsops;
> +	long type;
> +
> +	union {
> +		struct {
> +			struct kern_ipc_perm *perm;
> +			struct task_struct *target;
> +		} in;
> +
> +		struct {
> +			struct tsem_ipc_perm perm;
> +			u8 owner[HASH_MAX_DIGESTSIZE];
> +			u8 target[HASH_MAX_DIGESTSIZE];
> +		} out;
> +	};
> +};
> +
> +/**
> + * struct tsem_capability_args - TSEM arguments for capability handling.
> + * @cap: A capability specified for an event.
> + * @opts: Options for handling a capabilities command.
> + * @effective: The effective capability that is being manipulated.
> + * @inheritable: The inheritable capability that is being manipulated.
> + * @permitted: The permitted capability that is being manipulated.
> + * @target: The TASK_ID of the process whose capabilities are being
> + *	    requested.
> + *
> + * This structure is an encapsulation of the arguments to be retained
> + * for security event descriptions that describe security events
> + * involving process capabilities.
> + */
> +struct tsem_capability_args {
> +	int cap;
> +	unsigned int opts;
> +
> +	kernel_cap_t effective;
> +	kernel_cap_t inheritable;
> +	kernel_cap_t permitted;
> +
> +	u8 target[HASH_MAX_DIGESTSIZE];
> +};
> +
> +/**
> + * struct tsem_event - TSEM security event description.
> + * @kref: Reference count structure to track event lifetime.
> + * @list: The list of security events in a security modeling namespace.
> + * @work: The work structure that manages the workqueue being used to
> + *	  refill the event magazine structures.
> + * @event: The enumeration type describing the security event that the
> + *	   structure is defining.
> + * @locked: A boolean flag used to indicate whether or not the
> + *	    security event is running in atomic context.
> + * @instance: The process instance number that is executing the
> + *	      event described by the structure.
> + * @p_instance: The parent process instance number of the process
> + *		executing the event described by the structure.
> + * @pid: The process id number, in the global pid namespace, of the
> + *	 task that is executing the security event.
> + * @comm: A pointer to a null terminated buffer containing the name of
> + *	  the process that is requesting the security event.
> + * @digestsize: The size in bytes of the cryptographic hash function
> + *		that is being used in the security modeling namespace
> + *		in which the event occurred.
> + * @task_id: The TSEM TASK_ID of the process that generated the
> + *	     security event described by an instance of this
> + *	     structure.
> + * @mapping: The security state coefficient that the event described
> + *	     by this structure generates.
> + * @COE: The tsem_COE structure that describes the Context Of
> + *	 Execution that generated the event described by this
> + *	 structure.
> + * @no_params: A boolean value that is set if the security event
> + *	       has no characterizing parameters.
> + * @CELL: The CELL union is used to hold the data structures that
> + *	  characterize the CELL mapping of the event.
> + * @CELL.value: A single numeric value that may be used in
> + *		characterizing an event.
> + * @CELL.netlink: A structure describing  parameters that characterize
> + *		  an event inolving a netlink event.
> + * @CELL.inode: A structure describing characters of security events
> + *		that address inode manipulation operations.
> + * @CELL.file: A structure characterizing a file used as an arguement
> + *	       for a security event.
> + * @CELL.mmap_file: The structure describing the characteristics of
> + *		    a security event involving a memory mapping event.
> + * @CELL.socket: A structure characterizing security events that
> + *		 involve a socket.
> + * @CELL.kernel: A structure characterizing kernel I/O or memory
> + *		 loading opeations.
> + * @CELL.task_kill: The structure describing the characteristics of an
> + *		    event sending a signal to a process.
> + * @CELL.task_prlimit: A structure describing a security event that
> + *		       sets process resource limits.
> + * @CELL.task_prctl: A structure describing an event involving the
> + *		     process control operations.
> + * @CELL.inode_attr: A structure describing events involving getting
> + *		     or setting of inode attributes.
> + * @CELL.inode_xattr: A structure describing events involving actions
> + *		      on inode extended attributes.
> + * @CELL.key: A structure describing events involving manipulation of
> + *	      a kernel key.
> + * @CELL.sb: A structure describing events that involve the a
> + *	     filesystem superblock.
> + * @CELL.quota: A structure describing events that involve the
> + *		manipulation of filesystem quotas.
> + * @CELL.time: A structure describing the setting of the system time
> + *	       or timezone.
> + * @CELL.bpf: A structure describing involves involving manipulation
> + *	      of BPF functionality
> + * @CELL.ipc: A structure describing events that are manipulating
> + *	      shared memory structures or operations.
> + * @CELL.capability: A structure describing events that manipulate
> + *		     the capabilities of a process.
> + *
> + * This structure is the primary data structure for describing
> + * security events that occur in a security modeling namespace.  Each
> + * unique security coefficient in the namespace will have one of these
> + * structures associated with it.
> + *
> + * This structure encapsulates the following three major sources of
> + * information about the event:
> + *
> + * * A description of the process initiating the event.
> + * * The characteristics of the COE identity of the event.
> + * * The characteristics of the CELL identity of the event.
> + *
> + * Since one event description has to ultimately characterize any
> + * security event that can occur, the strategy is to use a union that
> + * contains security event specific structures that describe the
> + * characteristics of the event.  The event member of the structure
> + * is used to indicate the structure that should be referenced.
> + *
> + * The kref member of this structure is used to track the lifetime of
> + * an instance of this structure.  For example, in the case of an
> + * externally modeled event, when the export of the event description
> + * is complete.  In the case of an internally modeled namespace the
> + * structure will be released if it represents a security state
> + * coefficient that is already present in the model.  The structures
> + * are also released when an internally modeled namespace terminates.
> + *
> + * The work member of this structure is used to support asynchronous
> + * updates to a TPM for the root modeling domain.  Asynchronous
> + * updates are used to improve the performance of modeling and to
> + * handle security events that are running in atomic context and
> + * cannot be scheduled away while the TPM transaction completes.
> + *
> + * The tsem_event_allocate() function is called by a TSEM security
> + * event handler to allocate and populate an instance of this
> + * structure.  The locked member of this structure is used to
> + * determine whether the structure should be allocated from the
> + * kmem_cache based structure pool or from the magazine of structures
> + * help for processes running in atomic context.
> + *
> + * After the event is mapped this structure is either passed to the
> + * internal trusted modeling agent or the contents of this structure
> + * is exported to the trust orchestrator attached to the namespace for
> + * modeling by an external trusted modeling agent.
> + */
> +struct tsem_event {
> +	struct kref kref;
> +	struct list_head list;
> +	struct work_struct work;
> +
> +	enum tsem_event_type event;
> +	bool locked;
> +	u64 instance;
> +	u64 p_instance;
> +	u64 timestamp;
> +	pid_t pid;
> +	char comm[TASK_COMM_LEN];
> +
> +	unsigned int digestsize;
> +	u8 task_id[HASH_MAX_DIGESTSIZE];
> +	u8 p_task_id[HASH_MAX_DIGESTSIZE];
> +	u8 mapping[HASH_MAX_DIGESTSIZE];
> +
> +	struct tsem_COE COE;
> +
> +	bool no_params;
> +	union {
> +		int value;
> +		struct tsem_netlink_args netlink;
> +		struct tsem_inode_args inode;
> +		struct tsem_file_args file;
> +		struct tsem_mmap_file_args mmap_file;
> +		struct tsem_socket_args socket;
> +		struct tsem_kernel_args kernel;
> +		struct tsem_task_kill_args task_kill;
> +		struct tsem_task_prlimit_args task_prlimit;
> +		struct tsem_task_prctl_args task_prctl;
> +		struct tsem_inode_attr_args inode_attr;
> +		struct tsem_inode_xattr_args inode_xattr;
> +		struct tsem_key_args key;
> +		struct tsem_sb_args sb;
> +		struct tsem_quota_args quota;
> +		struct tsem_time_args time;
> +		struct tsem_bpf_args bpf;
> +		struct tsem_ipc_args ipc;
> +		struct tsem_capability_args capability;
> +
> +	} CELL;
> +};
> +
> +/**
> + * struct tsem_event_point - TSEM security coefficient characteristics.
> + * @list: The list of all the security state coefficients for a
> + *	   modeling namespace.
> + * @valid: A boolean value use to indicate whether or not the security
> + *	   state point is a valid coefficient in the model.
> + * @count: The number of times this coefficient has been expressed by
> + *	   the security modeling namespace.
> + * @point: The security state coefficient for a security event.
> + *
> + * This structure is used by internal trusted modeling agents to
> + * represent each unique security coefficient in a security model.
> + * Security state coefficients are unique within a model so only one
> + * struct tsem_event_point structure will be generated regardless of
> + * how many times the security event that generates the point occurs.
> + * The count member of this structure represents the total number of
> + * security events that have occurred generated this point.
> + *
> + * The valid member of this structure is used to flag whether this
> + * is consistent with the model for the namespace or was generated by
> + * a 'forensic', ie. out of model, event.
> + *
> + * Within each security namespace these structures are linked together
> + * in a list that describes the functional security value of the
> + * namespace.  Entries are only added to this list and never removed.
> + *
> + * The desired state of a security model is created by using the TSEM
> + * control plane to inject a list of acceptable security state
> + * coefficients into the model.  Sealing a model causes any security
> + * events that produce a coefficient different from those already in
> + * the model to be rejected as an invalid security event and logged as
> + * a forensic event for the model.
> + */
> +struct tsem_event_point {
> +	struct list_head list;
> +	bool valid;
> +	u64 count;
> +	u8 point[HASH_MAX_DIGESTSIZE];
> +};
> +
> +/**
> + * struct tsem_inode - TSEM inode status structure.
> + * @create_mutex: The mutex that protects the create_list.
> + * @create_list: The list of structures that contain ownership and instance
> + *		 information for inodes created under a directory.
> + * @instance_mutex: The mutex protecting the instance_list.
> + * @instance_list: The list of task identities that have created inodes
> + *		   under a directory and the instance count of inodes
> + *		   for each TASK_ID.
> + * @digest_mutex: The mutex protecting the digest_list.
> + * @digest_list: A list of structures containing the digest values that
> + *		 have been calculated for the inode.
> + * @status: The status of the inode.  See the discussion of enum
> + *	    tsem_inode_state for the information that is conveyed
> + *	    by this member.
> + * @created: A boolean flag to indicate that this inode was created
> + *	     in the context of a security modeling namespace.
> + * @creator: The context identity of the security modeling namespace that
> + *	     created the inode.
> + * @instance: The inode instance number for the TASK_ID that created
> + *	      the inode.
> + * @owner: The TASK_ID of the process that created the inode.
> + *
> + * This structure is used to contain the TSEM security state of an
> + * inode.
> + *
> + * Three lists are managed by this structure:
> + *
> + * An inode that is a directory will have inodes that are create under
> + * it added to the create_list.  This list will be traversed when the
> + * inode is instantiated so creation information about the inode can
> + * be registered in the tsem_inode structure attached to that inode.
> + *
> + * The instance_list is also maintained by a directory inode and is
> + * used to track the instances of an inode that is created under the
> + * directory by specific TASK_ID's.
> + *
> + * The digest_list is used for inodes that are backing files and is
> + * used to track the various cryptographic digest values that have
> + * been computed for the file.  This supports the use of multiple
> + * simultaneous digest values across multiple security modeling
> + * namespaces.
> + *
> + * The status member of this function serves two purposes:
> + *
> + * For file based inodes the status member is used to indicate
> + * whether or not the digest value is being computed.  The
> + * tsem_file_open handler uses this status variable to determine
> + * whether or not the modeling of an event should be bypassed if the
> + * file is being opened by the kernel to compute the digest value of
> + * the file.
> + *
> + * The second role of the status member is to indicate that the inode
> + * is one of the TSEM control plane files.  This allows modeling of
> + * events involving this inode to be bypassed in order to avoid a
> + * 'Heisenberg Deadlock' situation.
> + */
> +struct tsem_inode {
> +	struct mutex create_mutex;
> +	struct list_head create_list;
> +
> +	struct mutex instance_mutex;
> +	struct list_head instance_list;
> +
> +	struct mutex digest_mutex;
> +	struct list_head digest_list;
> +
> +	enum tsem_inode_state status;
> +	bool created;
> +	u64 creator;
> +	u64 instance;
> +	u8 owner[HASH_MAX_DIGESTSIZE];
> +};
> +
> +/**
> + * struct tsem_ipc - TSEM IPC security structure.
> + * @owner: The identity of the task that created the IPC resource.
> + *
> + * This structure is used to track the TASK_ID of the process that
> + * created the IPC memory resource so that information can be
> + * integrated into security coefficients that are generated for
> + * shared memory events.
> + */
> +struct tsem_ipc {
> +	u8 owner[HASH_MAX_DIGESTSIZE];
> +};
> +
> +/**
> + * struct tsem_inode_digest - Digest specific file checksum.
> + * @list:	The list structure used to link multiple digest values
> + *		for an inode.
> + * @name:	A pointer to an allocated null-terminated character
> + *		buffer containing the name of the hash function that
> + *		generated the digest value represented by an instance
> + *		of this structure.
> + * @version:	The version number of the inode that generated the digest
> + *		value that is currently represented.
> + * @value:	The digest value of the file represented by the inode..
> + *
> + * A linked list of these structures is maintained for each inode that
> + * is modeled by TSEM and is used to support multiple hash specific
> + * digest values for a file represented by the inode.  The tsem_inode
> + * structure that represents the TSEM security status of the inode
> + * contains a list of these structures.
> + *
> + * The name member of structure contains the name of the hash function
> + * that generated the checksum value.  This name is used to locate the
> + * correct structure by comparing its value against the hash function
> + * that is being used by the security modeling namespace that is
> + * traversing the list attempting to locate a previously computed
> + * digest value.
> + *
> + * The version member of the structure contains the inode version number
> + * that was in effect when the last digest value of this type was computed.
> + * This version number value is used to detect changes and to trigger an
> + * update of the digest value.
> + */
> +struct tsem_inode_digest {
> +	struct list_head list;
> +	char *name;
> +	u64 version;
> +	u8 value[HASH_MAX_DIGESTSIZE];
> +};
> +
> +/*
> + * The following three variables are the only globally visible
> + * variables used in the TSEM implementation.
> + *
> + * The tsem_blob_sizes variable is used by the LSM infrastructure to
> + * describe the amount of space that will be needed by the TSEM
> + * security structures.
> + *
> + * The tsem_names array is defined in the tsem.c file and contains an
> + * array of pointers to the strings that define the names for each of
> + * the TSEM security event handlers.  The enum tsem_event_type
> + * enumeration indexes this array.
> + *
> + * The tsem_root_actions array is also indexed by the tsem_event_type
> + * enumeration and is used to determine the type of response that a
> + * TSEM security event handler is to return to the caller, ie. either
> + * logging or enforcing.  The contents of this array is inherited by
> + * copying the array into the struct tsem_context structure for
> + * modeling namespaces that are subordinate to the root model.
> + */
> +extern struct lsm_blob_sizes tsem_blob_sizes;
> +extern const char * const tsem_names[TSEM_EVENT_CNT];
> +extern enum tsem_action_type tsem_root_actions[TSEM_EVENT_CNT];
> +
> +/*
> + * The following section of the file contains the definitions for the
> + * externally visible functions in each of the TSEM compilation units.
> + */
> +extern struct dentry *tsem_fs_create_external(const char *name);
> +extern void tsem_fs_show_trajectory(struct seq_file *c, struct tsem_event *ep);
> +extern void tsem_fs_show_field(struct seq_file *c, const char *field);
> +extern void tsem_fs_show_key(struct seq_file *c, char *term, char *key,
> +			     char *fmt, ...);
> +extern int tsem_fs_init(void);
> +
> +extern struct tsem_model *tsem_model_allocate(size_t size);
> +extern void tsem_model_free(struct tsem_context *ctx);
> +extern int tsem_model_event(struct tsem_event *ep);
> +extern int tsem_model_load_point(u8 *point);
> +extern int tsem_model_load_pseudonym(u8 *mapping);
> +extern int tsem_model_has_pseudonym(struct tsem_inode *tsip, char *pathname);
> +extern void tsem_model_load_base(u8 *mapping);
> +extern int tsem_model_add_aggregate(void);
> +extern void tsem_model_compute_state(void);
> +extern void tsem_model_magazine_free(struct tsem_model *model);
> +extern int tsem_model_cache_init(struct tsem_model *model, size_t size);
> +
> +extern void tsem_ns_put(struct tsem_context *ctx);
> +extern int tsem_ns_event_key(u8 *task_key, const char *keystr, u8 *key);
> +extern int tsem_ns_create(const enum tsem_control_type type,
> +			  const char *digest, const enum tsem_ns_reference ns,
> +			  const char *key, const unsigned int cache_size);
> +extern int tsem_ns_export_root(unsigned int magazine_size);
> +
> +extern int tsem_export_show(struct seq_file *m, void *v);
> +extern int tsem_export_event(struct tsem_event *ep);
> +extern int tsem_export_action(enum tsem_event_type event, bool locked);
> +extern int tsem_export_aggregate(void);
> +extern int tsem_export_magazine_allocate(struct tsem_external *ext,
> +					 size_t size);
> +extern void tsem_export_magazine_free(struct tsem_external *ext);
> +extern int tsem_export_cache_init(void);
> +
> +extern int tsem_map_task(struct file *file, u8 *mapping);
> +int tsem_map_event(struct tsem_event *ep);
> +
> +extern struct tsem_event *tsem_event_allocate(enum tsem_event_type event,
> +					      bool locked);
> +extern int tsem_event_init(struct tsem_event *ep);
> +extern void tsem_event_put(struct tsem_event *ep);
> +extern void tsem_event_get(struct tsem_event *ep);
> +extern int tsem_event_magazine_allocate(struct tsem_context *ctx, size_t size);
> +extern void tsem_event_magazine_free(struct tsem_context *ctx);
> +extern int tsem_event_cache_init(void);
> +
> +extern u8 *tsem_trust_aggregate(void);
> +extern int tsem_trust_add_event(struct tsem_event *ep);
> +
> +/*
> + * The remaining inline function declarations follow the design
> + * pattern of the other LSM's and implement functions that return
> + * various TSEM characteristics of tasks, modeling contexts and
> + * inodes.
> + */
> +static inline struct tsem_task *tsem_task(const struct task_struct *task)
> +{
> +	return task->security + tsem_blob_sizes.lbs_task;
> +}
> +
> +static inline bool tsem_task_trusted(struct task_struct *task)
> +{
> +	return tsem_task(task)->trust_status & TSEM_TASK_TRUSTED;
> +}
> +
> +static inline bool tsem_task_untrusted(struct task_struct *task)
> +{
> +	return tsem_task(task)->trust_status & ~TSEM_TASK_TRUSTED;
> +}
> +
> +static inline struct tsem_context *tsem_context(struct task_struct *task)
> +{
> +	return tsem_task(task)->context;
> +}
> +
> +static inline struct tsem_model *tsem_model(struct task_struct *task)
> +{
> +	return tsem_task(task)->context->model;
> +}
> +
> +static inline struct tsem_inode *tsem_inode(struct inode *inode)
> +{
> +	return inode->i_security + tsem_blob_sizes.lbs_inode;
> +}
> +
> +static inline struct tsem_ipc *tsem_ipc(struct kern_ipc_perm *kipc)
> +{
> +	return kipc->security + tsem_blob_sizes.lbs_ipc;
> +}
> +
> +static inline struct crypto_shash *tsem_digest(void)
> +{
> +	return tsem_context(current)->tfm;
> +}
> +
> +static inline unsigned int tsem_digestsize(void)
> +{
> +	return crypto_shash_digestsize(tsem_digest());
> +}

