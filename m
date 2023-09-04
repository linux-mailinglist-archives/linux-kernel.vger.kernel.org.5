Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4212B791E42
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbjIDUdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjIDUdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:33:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9436187;
        Mon,  4 Sep 2023 13:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BC00B80CAA;
        Mon,  4 Sep 2023 20:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AD4C433C7;
        Mon,  4 Sep 2023 20:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693859594;
        bh=+eWl5kLcO7BFy99uHkEkRDqPs56gaOnIfVVg3QlSf0w=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=iPv6oHtYWEr3TunLNPQuiysJTVw2ltop+e9QFQu+0mRUxuqFL6W4lFMt+ASYz6INi
         mXXmFsHraRvcBJ8f9ok3wnv/luR7Gg1/fFkj0MRZIdxl0rx16T2RGXw55xPDYvHzmL
         Rv927zxEOcqUibgGeqrslYEtx08e2KW8OiIwegCiHZ5VyxWN57UQb5HxVtP1I9+LPq
         3MQHDlS8L5YHkpJadqvgHw03sQCmlClparHsRcSWTG+X0nT+dtllt3cBj1ghwg8hKs
         xpMhb5HrJfACpeYVhSJ8Qdbr51+ATtuaQ/I8vM3HyxHbzugAB93i5zs/tPmsyFFlx2
         w7FRxwU5407bQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 04 Sep 2023 23:33:11 +0300
Message-Id: <CVAF41PVDIAA.1PC7HPMFED1DI@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 12/13] selftests/sgx: Discard unsupported ELF
 sections
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230831134144.22686-1-jo.vanbulck@cs.kuleuven.be>
 <20230831134144.22686-13-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230831134144.22686-13-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 31, 2023 at 4:41 PM EEST, Jo Van Bulck wrote:
> Building the test enclave with -static-pie may produce a dynamic symbol
> table, but this is not supported for enclaves and any relocations need to
> happen manually (e.g., as for "encl_op_array"). Thus, opportunistically
> discard ".dyn*" and ".gnu.hash" which the enclave loader cannot handle.
>
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> ---
>  tools/testing/selftests/sgx/test_encl.lds | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/se=
lftests/sgx/test_encl.lds
> index 333a3e78fdc9..ffe851a1cac4 100644
> --- a/tools/testing/selftests/sgx/test_encl.lds
> +++ b/tools/testing/selftests/sgx/test_encl.lds
> @@ -33,6 +33,8 @@ SECTIONS
>  		*(.note*)
>  		*(.debug*)
>  		*(.eh_frame*)
> +		*(.dyn*)
> +		*(.gnu.hash)
>  	}
>  }
> =20
> --=20
> 2.25.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Also, for any patches (not that many) I've done post-Intel: I hereby
give permission to license that code with MIT or compatible license
as the upper bound.

For any code I've produced while at Intel the copyright is owned by
Intel so perhaps Dave could help with that part?

I'm happy if this code ends up to wider use than just kselftest for
sure.

BR, Jarkko
