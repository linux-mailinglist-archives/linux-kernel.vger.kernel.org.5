Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D937A1EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbjIOMk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjIOMkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:40:53 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C9EA1;
        Fri, 15 Sep 2023 05:40:48 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38FCec0M060781;
        Fri, 15 Sep 2023 07:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694781638;
        bh=W+CQX+PQxv7bZvfqrrCiK8lwgG8+dPJOJah21/aVynY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=HDSz4gS83suDNv9dLJr3RRMgy/o/W/oarhr13csUiPMqyop3iCWqnMnWCp/BnOv0H
         xXOWv/1qpriK2sfSRIXyRwWE/E91pT8ok2Ztsr/BAGsKGsPHsrSm8VhloIZw4bRDFL
         uzgjzat3VmibbLX1HBQ4tHc61xpZ7CCAvqw3/EiA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38FCectL113296
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Sep 2023 07:40:38 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Sep 2023 07:40:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Sep 2023 07:40:38 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38FCecso012546;
        Fri, 15 Sep 2023 07:40:38 -0500
Date:   Fri, 15 Sep 2023 07:40:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Justin Stitt <justinstitt@google.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] firmware: ti_sci: refactor deprecated strncpy
Message-ID: <20230915124038.vmj3gzthboypzp3v@parsnip>
References: <20230913-strncpy-drivers-firmware-ti_sci-c-v1-1-740db471110d@google.com>
 <202309142103.6DFFDEB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202309142103.6DFFDEB@keescook>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:03-20230914, Kees Cook wrote:
> On Wed, Sep 13, 2023 at 08:23:02PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> > 
> > We should prefer more robust and less ambiguous string interfaces.
> > 
> > A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> > NUL-termination on the destination buffer.
> > 
> > It does not seem like `ver->firmware_description` requires NUL-padding
> > (which is a behavior that strncpy provides) but if it does let's opt for
> > `strscpy_pad()`.
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
> Looks right to me.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Does this belong to stable as well? If so, please add appropriate stable
process.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
