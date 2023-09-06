Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E0C7940B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbjIFPso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242197AbjIFPsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:48:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4021981;
        Wed,  6 Sep 2023 08:48:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5EA1F22430;
        Wed,  6 Sep 2023 15:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694015316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sv/31sCHIcei+WRZYVLMLL1XlsVosFEEvnZ9ESD+cHU=;
        b=z0XUU4zLteiGKOrGZnrJwvv+89Om59fbVXo9G0tGdAxZblB0FBVUk18bzCT53Nl6vih+oA
        sGDwsxTcMKUMhfz4F2bkm3llZajSwdZybmm5j/XvaKqVVYM6KgGviaxCBqBFxzjeBSc7Gf
        oY9EivvHB6Fb+APAQFe5+z8fw1hCr/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694015316;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sv/31sCHIcei+WRZYVLMLL1XlsVosFEEvnZ9ESD+cHU=;
        b=XBD3nRiMbT3fUMhM+KICw0ANBH5oz/PldZ5n31tIWzLT5XE/UFX6EZnQpQzQfCQLES2u2U
        bcMea5uBODi8RhBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 213511333E;
        Wed,  6 Sep 2023 15:48:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PgGmBlSf+GS2bAAAMHmgww
        (envelope-from <aherrmann@suse.de>); Wed, 06 Sep 2023 15:48:36 +0000
Date:   Wed, 6 Sep 2023 17:49:59 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nikita Kravets <teackot@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH] platform/x86: msi-ec: Fix the build
Message-ID: <20230906154440.GG26808@alberich>
References: <20230805101010.54d49e91@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230805101010.54d49e91@endymion.delvare>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 10:10:10AM +0200, Jean Delvare wrote:
> The msi-ec driver fails to build for me (gcc 7.5):

FWIW.

The driver builds under TW with gcc 13.x.

I suppose that this issue was fixed in gcc 8.
I am currently double checking this.


PS: You had an odd email-address in CC:
    (Nikita@imap2.suse-dmz.suse.de).

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG Nürnberg)
