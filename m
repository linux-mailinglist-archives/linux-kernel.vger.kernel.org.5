Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3202080252C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 16:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjLCPfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 10:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCPfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 10:35:30 -0500
X-Greylist: delayed 912 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Dec 2023 07:35:35 PST
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81145EB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 07:35:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701616815; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=eYcydZADgBwwmoZblNuT1RKS7p0K0EFu2Ml8PbKSdPQlYQsQ+P5sGR3sP5BKVJhlqEefhEBcy0oz40+UPn3T7Wq/lRohpWHzPjnvmQTBo1qfbSk5Lej5NYr04boc05CLRN0Zi1Y7QlA94VSmH9w5BuJ/mvsITMiNVuH65BBeMl0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1701616815; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=y9XeZ+iJkmuLLerw0M8XG9OFFBL0oAblHVfL56dhrDo=; 
        b=M8M4CXnvq8mX8QCvBd1svk1RiqvOOnYvMFSxf2Ufy9XyA5/pynnGki7zZ2YJ7XL9j02WQZAHZKEhes+hlxvVSvAwKSBmFWaSC3XAhZfpIKejP8Ib4JeI3AWUVmx17qZ7CG9ZRX3wd0JHcnJygnoeuf/3dDEfbzvzzQLTQDdk6wg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=sanganaka@siddh.me;
        dmarc=pass header.from=<sanganaka@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701616815;
        s=zmail; d=siddh.me; i=sanganaka@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=y9XeZ+iJkmuLLerw0M8XG9OFFBL0oAblHVfL56dhrDo=;
        b=iBFvo86QOlUMRF/E22g5j9Cn8xDDmV3MFJSzdAhMmj3WOWmVsI6+IX04EWgtvqH+
        I0muLJRx48+5R/TlQoqIBAdNRZ0hwUSJxX9PbdbjDLtvhrq+cwxF5nt8eONaP5A7r2Z
        Knif18Dp1Jp+cmS2pk5h6t+xn5nJmSLi8dDFBsJ0=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1701616784145640.3998822073255; Sun, 3 Dec 2023 20:49:44 +0530 (IST)
Date:   Sun, 03 Dec 2023 20:49:44 +0530
From:   Siddh Raman Pant <sanganaka@siddh.me>
To:     "Andy Whitcroft" <apw@canonical.com>,
        "Joe Perches" <joe@perches.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <18c30439301.5cd4b13e44397.8467191155746202006@siddh.me>
In-Reply-To: 
Subject: [BUG] Checkpatch gives long-line warnings for Reported-*-by
 variants
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Checkpatch Maintainers,

Checkpatch gives COMMIT_LOG_LONG_LINE warning for the signature line
with Reported-and-tested-by and other variants. The $signature_tags
variable does not account for them.

This warning will be encountered without fail when using long names
and email addresses, for eg. the syzkaller's email addresses which
contains a 20 char identifier.

Unfortunately, I don't know perl enough to send a patch. Hence, I
request you to please fix this false positive warning.

Thanks,
Siddh

