Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4FB76020E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjGXWPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjGXWPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:15:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E38410EC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 15:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD17661456
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65425C433C8;
        Mon, 24 Jul 2023 22:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690236908;
        bh=5xU8tBKog8sD1JT305O0sYBJ6mz8EHv0yDqZFATvuNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dr7Xp5wnxDZjFEfx+9tLIR9i1MgWSC/hswijslOzxPFHq9W87Z22xM9hkc0K3vLAP
         535QD2ZHp8H6dMsCMjtoKd7buT93O2EG0PYYq5oP7PzSYdR9F06z2WV33nxLLK+tRe
         YyxFhBZdYX4f/GfwsfYB1BnUwCRMjtwmb+E+dppsrvTJeNKzCpvo5c9oxr2lA8VVCg
         qKxUa2v/dRoWOUMsZ2WQgV7hwUnYdoCAB+1yjRpTnFPSAaxRIoyjH6TimHB8X6Zuq4
         DlwzGY69RwYl19StgzX/UPl0XyknSrEtRWV0cV4R9Ar4sm0NYIA/F+yUJmvGES3+Vt
         x9dudg89G0hqw==
Date:   Mon, 24 Jul 2023 15:15:07 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        ast@kernel.org, martin.lau@kernel.org, yhs@fb.com,
        andrii@kernel.org, void@manifault.com, houtao1@huawei.com,
        laoar.shao@gmail.com, inwardvessel@gmail.com, kuniyu@amazon.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1] bpf: Add length check for
 SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
Message-ID: <20230724151507.6b725396@kernel.org>
In-Reply-To: <20230723075452.3711158-1-linma@zju.edu.cn>
References: <20230723075452.3711158-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2023 15:54:52 +0800 Lin Ma wrote:
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index d4172534dfa8..6f1afbb394a6 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -511,6 +511,11 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
>  		if (nla_type(nla) != SK_DIAG_BPF_STORAGE_REQ_MAP_FD)
>  			continue;
>  
> +		if (nla_len(nla) < sizeof(map_fd)) {
> +			err = -EINVAL;
> +			goto err_free;
> +		}

You can move this check earlier, when the attributes are getting
counted. That way we can avoid the alloc/free on error.
