Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864B08061D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346520AbjLEWla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346259AbjLEWl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:41:28 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE77194;
        Tue,  5 Dec 2023 14:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1701816092;
        bh=RADxu9DladnQuPEEYoqwAwtdXSXRn/xTNYBYSRG5xo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/PNNhz098jJeinwKz9W78Z/IkTsMAJx5V+pSEhr4QKMjximz0mHEI++EZLdFLO4J
         vDluKmBkcgJaQR9esCp68WX7p23oBKby429p1/qDixTqPQ5ZCEtoy0jyLA5Qpdngtt
         rRVvBy2a7wrG3xl6a2k3X3JLJxw0hCZ7TyFYl7js=
Date:   Tue, 5 Dec 2023 23:41:32 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Granados <j.granados@samsung.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 13/18] sysctl: move sysctl type to ctl_table_header
Message-ID: <4a93cdb4-031c-4f77-8697-ce7fb42afa4a@t-8ch.de>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231204-const-sysctl-v2-13-7a5060b11447@weissschuh.net>
 <ZW+lQqOSYFfeh8z2@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZW+lQqOSYFfeh8z2@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-05 14:33:38-0800, Luis Chamberlain wrote:
> On Mon, Dec 04, 2023 at 08:52:26AM +0100, Thomas Weißschuh wrote:
> > @@ -231,7 +231,8 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
> >  		return -EROFS;
> >  
> >  	/* Am I creating a permanently empty directory? */
> > -	if (sysctl_is_perm_empty_ctl_header(header)) {
> > +	if (header->ctl_table == sysctl_mount_point ||
> > +	    sysctl_is_perm_empty_ctl_header(header)) {
> >  		if (!RB_EMPTY_ROOT(&dir->root))
> >  			return -EINVAL;
> >  		sysctl_set_perm_empty_ctl_header(dir_h);
> 
> While you're at it.

This hunk is completely gone in v3/the code that you merged.

> This just made me cringe, and curious if some other changes
> could be done to make this obviously clear during patch review
> that this is safe.

Which kind of unsafety do you envision here?
