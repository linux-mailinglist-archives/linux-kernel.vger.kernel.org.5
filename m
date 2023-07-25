Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBF8762494
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjGYViM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjGYViK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:38:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA251FCF;
        Tue, 25 Jul 2023 14:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E94606186A;
        Tue, 25 Jul 2023 21:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2CFC433C7;
        Tue, 25 Jul 2023 21:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690321088;
        bh=iQnUOYEDM9zbdSaZI5cBSuRGjGkw1hFUZD3jQXC38sI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBzM7oer0Pi+VHosBQgnmCuPvCgtkPbWja2/R+y7xn62/LlA/msmhfYSD+N4+OyP6
         pLWfX+zMKhhwfRLHVzl89QjvzeQNbx1Y6in6ALH4epBp/CcP2j0/p3hbV96bL9okf8
         /opJOMb391x2aairp78OOjEg2h5UoPIIeCKbxHQKey1FWcoSfeCNHM/LZtpzr3w6Lf
         4ZNH2w4wnR5KZaECabTSp7KfBhF67ne9tgx5p1TDG5cWcBcYzrFPdWn7wcH0dRa5qE
         mIEisYZPEvEpJ+O8HPsvjlI2Q2L+CekAnyGyrRXyTcnoqmbaUrjNrsGp44bNgRbLS+
         StlCS/6giwZjA==
Date:   Tue, 25 Jul 2023 14:38:05 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v2 2/2] scripts/faddr2line: Constrain readelf output to
 symbols from System.map
Message-ID: <20230725213805.g6osfswz5o6cxusy@treble>
References: <20230725211157.17031-1-will@kernel.org>
 <20230725211157.17031-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230725211157.17031-3-will@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:11:57PM +0100, Will Deacon wrote:
> @@ -185,7 +186,7 @@ __faddr2line() {
>  				found=2
>  				break
>  			fi
> -		done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
> +		done < <(${READELF} --symbols --wide $objfile | sed -f ${IGNORED_SYMS} -e 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
>  
>  		if [[ $found = 0 ]]; then
>  			warn "can't find symbol: sym_name: $sym_name sym_sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"

Looks good, though the outer loop has another readelf incantation:

	done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v fn=$sym_name '$4 == "FUNC" && $8 == fn')

It should probably have the same sed options?  Also it looks like it's
wrongly checking for FUNC.

-- 
Josh
