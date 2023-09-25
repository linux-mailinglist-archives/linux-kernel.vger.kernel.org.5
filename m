Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DFE7ADD5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjIYQoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjIYQoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:44:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC03BE;
        Mon, 25 Sep 2023 09:44:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B52C433C8;
        Mon, 25 Sep 2023 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695660264;
        bh=RcsCUTJ6WPrPfmovT9/V50ARlRbqM5k1IHKyp/mjHN4=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=D9Wg6D7IUh8JaG6Aw0IDXHbUQQJyl3UJty8hbpGz9mTvhMgZRXz/syULmiH/KUQQ6
         D8RwxpvLVkpl0b+sjjs/avbGTxG3FWiLqOl5o7eXGWMETdMJB7+JmoAZFhOzUFFzzg
         cpvI4OAoV8DS200smzuvEFvaMg6kYFGseqGDN1JYyezqNyEy/DDMZhx+fTPnkvszru
         yH/ZYRdHaClFYSXg/ocb60oG7usU9L4AxQAS9p/rpngYnG0cUqLrsbw4MzXL4GrwQv
         G4g23o6stJ02HVwA//O7ZZZDhXgR2IAmHZWbE3IbW+JaQwYKLxjR+f2CN5SrvxWHSl
         OO2MSZ9VjVygg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 25 Sep 2023 19:44:20 +0300
Message-Id: <CVS5EA0J0L3K.3KYP9Y9K9DRSY@suppilovahvero>
Subject: Re: [PATCH v6 06/13] selftests/sgx: Remove redundant enclave base
 address save/restore
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     <dave.hansen@linux.intel.com>
X-Mailer: aerc 0.14.0
References: <20230921143604.6561-1-jo.vanbulck@cs.kuleuven.be>
 <20230921143604.6561-7-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230921143604.6561-7-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Sep 21, 2023 at 5:35 PM EEST, Jo Van Bulck wrote:
> Remove redundant push/pop pair that stores and restores the enclave base
> address in the test enclave, as it is never used after the pop and can
> anyway be easily retrieved via the __encl_base symbol.
>
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> Acked-by: Kai Huang <kai.huang@intel.com>
> ---
>  tools/testing/selftests/sgx/test_encl_bootstrap.S | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/te=
sting/selftests/sgx/test_encl_bootstrap.S
> index 03ae0f57e29d..e0ce993d3f2c 100644
> --- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
> +++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
> @@ -55,12 +55,9 @@ encl_entry_core:
>  	push	%rax
> =20
>  	push	%rcx # push the address after EENTER
> -	push	%rbx # push the enclave base address
> =20
>  	call	encl_body
> =20
> -	pop	%rbx # pop the enclave base address
> -
>  	/* Clear volatile GPRs, except RAX (EEXIT function). */
>  	xor     %rcx, %rcx
>  	xor     %rdx, %rdx
> --=20
> 2.25.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
