Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46FC810844
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378354AbjLMCdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378308AbjLMCdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:33:13 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E234BA0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:33:19 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1fab887fab8so4775753fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702434799; x=1703039599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3Z9JoyfzsY5Msgpk7J3xKwjEP4qsoLvyMDzNBboZxQ=;
        b=L63DWHSyw764lh5KFe1pB7SH3T/tPvsOkWuRvhOUWXJUbmDh54hBIgUaV6pF9O5zjJ
         7ApfXQlI2R/60ll3Uu9I9kYwxKmAD+Tlix5N3DsSk3plaLycVl5hjFECLDJAgSS75ztE
         qwo/IFy+vsv/dgM3qO8vSUi5S9ABmQizUkQSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702434799; x=1703039599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3Z9JoyfzsY5Msgpk7J3xKwjEP4qsoLvyMDzNBboZxQ=;
        b=jVLx8nUPk/cZbkQ1aUAcFZ/qUTCFNzirMU+aP8nKJxDvGztgmWh0U6U2NRcuOCKomk
         /rEEVmQGegUAf0ChjNFp85ZyVt4r3TFYQd8rDOlHmONV7M0HlYwfmxZkENJrFP3fmXrD
         Q0bJ64Itg3JBTOq1Xv7ltf3PPTwpgI0hQmcuBYRnI41gUKEXkcirWJuFgOvvL/On9Wr1
         cJ/Onf3drnpKqchx6RJEaoZNZP1izKKFQx4PzxMrjc5CGZVAeHZKg/ijGBGLWdze3Up9
         Nrw7RD7U1gQMddqDyFaxdMysqzVPu4BMFqC73TCVNjHBV+bM1x2yLfdLj2J9+YbmKqVa
         UIGA==
X-Gm-Message-State: AOJu0Yzkb8nf3QqHWnaAKIiW3pdO5dKdQmd7cdL/AhALNTAKjrqFmaGp
        mHF/URQVz5+ZbKNfAm2SZ9h01Q==
X-Google-Smtp-Source: AGHT+IE3whrRDNDQUcDGajjH0b22bNpJJTgCXoMQv6lkdzkXPDL1WhDozwCrzDj3USG8zDbkzGRDYQ==
X-Received: by 2002:a05:6870:d0c:b0:1fb:32a0:41ce with SMTP id mk12-20020a0568700d0c00b001fb32a041cemr9848854oab.0.1702434799232;
        Tue, 12 Dec 2023 18:33:19 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o17-20020a656151000000b005c2420fb198sm7667429pgv.37.2023.12.12.18.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 18:33:18 -0800 (PST)
Date:   Tue, 12 Dec 2023 18:33:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: fcoe: use sysfs_match_string over
 fcoe_parse_mode
Message-ID: <202312121833.E5062A3126@keescook>
References: <20231212-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v2-1-1f2d6b2fc409@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-strncpy-drivers-scsi-fcoe-fcoe_sysfs-c-v2-1-1f2d6b2fc409@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:19:06PM +0000, Justin Stitt wrote:
> Instead of copying @buf into a new buffer and carefully managing its
> newline/null-terminating status, we can just use sysfs_match_string()
> as it uses sysfs_streq() internally which handles newline/null-term:
> 
> |  /**
> |   * sysfs_streq - return true if strings are equal, modulo trailing newline
> |   * @s1: one string
> |   * @s2: another string
> |   *
> |   * This routine returns true iff two strings are equal, treating both
> |   * NUL and newline-then-NUL as equivalent string terminations.  It's
> |   * geared for use with sysfs input strings, which generally terminate
> |   * with newlines but are compared against values without newlines.
> |   */
> |  bool sysfs_streq(const char *s1, const char *s2)
> |  ...
> 
> Then entirely drop the now unused fcoe_parse_mode, being careful to
> change if condition from checking for FIP_CONN_TYPE_UNKNOWN to < 0 as
> sysfs_match_string can return -EINVAL. Also check explicitly if
> ctlr->mode is equal to FIP_CONN_TYPE_UNKNOWN -- this is probably
> preferred to "<=" as the behavior is more obvious while maintaining
> functionality.
> 
> To get the compiler not to complain, make fip_conn_type_names
> const char * const. Perhaps, this should also be done for
> fcf_state_names.
> 
> This also removes an instance of strncpy() which helps [1].
> 
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks great; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
