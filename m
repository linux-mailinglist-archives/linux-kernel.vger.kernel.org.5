Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFE9793D43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbjIFM7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjIFM7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:59:08 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78F6171C;
        Wed,  6 Sep 2023 05:59:02 -0700 (PDT)
Received: from [192.168.1.103] (178.176.74.104) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Wed, 6 Sep 2023
 15:58:58 +0300
Subject: Re: [PATCH] certs: Add the ability to add only CA certificates to the
 secondary trusted keyring
To:     Denis Glazkov <d.glazkov@omp.ru>
CC:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230906113211.82362-1-d.glazkov@omp.ru>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <f5a1d856-0482-a2c3-0e62-3ca911ce3dd2@omp.ru>
Date:   Wed, 6 Sep 2023 15:58:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230906113211.82362-1-d.glazkov@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.74.104]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 09/06/2023 12:39:25
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 179691 [Sep 06 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 530 530 ecb1547b3f72d1df4c71c0b60e67ba6b4aea5432
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.104 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;178.176.74.104:7.1.2;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {rdns complete}
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.74.104
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/06/2023 12:43:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/6/2023 11:30:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 2:32 PM, Denis Glazkov wrote:

> When building a chain of trust for IMA certificates issued from

   It's a shame I forgot what IMA stands for... and even Google doesn't
give any suitable value...

> intermediate certificates using a secondary trusted keying, there
> is no way to restrict the addition of IMA certificates to trusted
> certificates, since any certificate signed by an built-in or
> secondary trusted certificate can be added to the secondary
> trusted keying.
> 
> With root privileges, an attacker can load a certificate intended
> for IMA into the trusted certificates and sign the kernel modules
> with the corresponding private key. This allows an attacker to
> load untrusted modules into kernel space.
> 
> This patch adds the configuration that once enabled, only
> certificates that meet the following requirements can be added
> to the secondary trusted keying:
> 
> 1. The certificate is a CA.

   Oh, and I also forgot what CA stands for... :-/

> 2. The certificate must be used for verifying a CA's signatures.
> 3. The certificate must not be used for digital signatures.
> 
> Signed-off-by: Denis Glazkov <d.glazkov@omp.ru>
[...]

> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 9de610bf1f4b..8d45c19ba92e 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -90,6 +90,10 @@ int restrict_link_by_builtin_and_secondary_trusted(
>  	const union key_payload *payload,
>  	struct key *restrict_key)
>  {
> +#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING_FOR_CA_CERTIFICATES_ONLY
> +	struct public_key *pub;
> +#endif

   Mhm, why this is not a part of the *if* block in the next hunk?
You don't use this variable outside that block...

[...]
> @@ -99,6 +103,23 @@ int restrict_link_by_builtin_and_secondary_trusted(
>  		/* Allow the builtin keyring to be added to the secondary */
>  		return 0;
>  
> +#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING_FOR_CA_CERTIFICATES_ONLY
> +	if (dest_keyring == secondary_trusted_keys) {
> +		if (type != &key_type_asymmetric)
> +			return -EOPNOTSUPP;
> +
> +		pub = payload->data[asym_crypto];

   I'm not seeing this index declared in Linus' repo...

> +		if (!pub)
> +			return -ENOPKG;
> +		if (!test_bit(KEY_EFLAG_CA, &pub->key_eflags))
> +			return -EPERM;
> +		if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pub->key_eflags))
> +			return -EPERM;
> +		if (test_bit(KEY_EFLAG_DIGITALSIG, &pub->key_eflags))
> +			return -EPERM;
> +	}
> +#endif
> +
>  	return restrict_link_by_signature(dest_keyring, type, payload,
>  					  secondary_trusted_keys);
>  }

MBR, Sergey
