Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE717AC4E9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 21:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjIWToK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 15:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIWToJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:44:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1529A197
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:44:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D54C433C7;
        Sat, 23 Sep 2023 19:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695498242;
        bh=ZqAxDBkadRBYi+U+AhUpYrnAgmaHkhyHSzWggXx7Ym4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=M+aVBFgwlCNw8IIr8DxxM51gINn4J/Ji/Pz89tgjLK1VO7hAkvVhuUBCi+qxO67u4
         3m9GXs91ef5bk2Fm2Zjz8vM+OHuBl1F53ZPDMhpya+yZTZJiSlKUjyq4TRPLPJgiB/
         xkQ+ZV7eG0NBRRLHSv7RgVf9FCl5k4oJqU1zIJV39GkYMqAcmdEY716u19pCX2gnta
         BSjgEm5I3ymiZDnJAFP1/e1PRWAzURfhuSP3UDrFI944hKOdP8JHOdtxICKQ7Fvf8o
         Zx2ZW/qnboz9qFLKRZ3hi2Kk8FbMBLt4I84cXQQAsNJlE/4Fy8AZHY+cS0Nv6yNMbi
         8qoHPEunRX2IQ==
Date:   Sat, 23 Sep 2023 12:43:59 -0700
From:   Kees Cook <kees@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>
CC:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_qed/red=5Fll2=3A_Fix_undefine?= =?US-ASCII?Q?d_behavior_bug_in_struct_qed=5Fll2=5Finfo?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZQ+Nz8DfPg56pIzr@work>
References: <ZQ+Nz8DfPg56pIzr@work>
Message-ID: <94131E7C-BC22-423B-8B05-234BB2E09EFD@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 23, 2023 6:15:59 PM PDT, "Gustavo A=2E R=2E Silva" <gustavoars=
@kernel=2Eorg> wrote:
>The flexible structure (a structure that contains a flexible-array member
>at the end) `qed_ll2_tx_packet` is nested within the second layer of
>`struct qed_ll2_info`:
>
>struct qed_ll2_tx_packet {
>	=2E=2E=2E
>        /* Flexible Array of bds_set determined by max_bds_per_packet */
>        struct {
>                struct core_tx_bd *txq_bd;
>                dma_addr_t tx_frag;
>                u16 frag_len;
>        } bds_set[];
>};
>
>struct qed_ll2_tx_queue {
>	=2E=2E=2E
>	struct qed_ll2_tx_packet cur_completing_packet;
>};
>
>struct qed_ll2_info {
>	=2E=2E=2E
>	struct qed_ll2_tx_queue tx_queue;
>        struct qed_ll2_cbs cbs;
>};

Nice find! Was this located with -Wflex-array-member-not-at-end ?=20

> [=2E=2E=2E]
>Fix this by moving the declaration of `cbs` to the  middle of its
>containing structure `qed_ll2_info`, preventing it from being
>overwritten by the contents of `bds_set` at run-time=2E
>
>This bug was introduced in 2017, when `bds_set` was converted to a
>one-element array, and started to be used as a Variable Length Object
>(VLO) at run-time=2E
>
>Fixes: f5823fe6897c ("qed: Add ll2 option to limit the number of bds per =
packet")
>Cc: stable@vger=2Ekernel=2Eorg
>Signed-off-by: Gustavo A=2E R=2E Silva <gustavoars@kernel=2Eorg>

Reviewed-by: Kees Cook <keescook@chromium=2Eorg>


--=20
Kees Cook
