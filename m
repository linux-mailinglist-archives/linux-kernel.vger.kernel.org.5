Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3386177D219
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbjHOSls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239291AbjHOSlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:41:31 -0400
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4261733
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:41:05 -0700 (PDT)
Message-ID: <2f7522c01a45f9052f423869040258ba.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1692124835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJjeneACakyjixftgTs3skIu5CB0b3rHbi9cca9HEnA=;
        b=FJZrpg01mrmsoPHkhHAzaxo7ZZ55i2jvKk8EBea5OB1Cs9dZR1rEnUQ9wi6LPFJBGUw2UV
        qzTNWHJefPmnrYbNk5hPeEaXR5iojvWA6SsP8lnHJRuQDlR4SIcFNv23uhmU/9EwJUcjF4
        Yl/YfPlXTmPqco74Oy5eAu2j1Dfw/eWsnRorHz6zDU78VYQ2qLJJ0Y53glF9r8UjGa4KAw
        xVR1qE13dfMrFBGTuEtho0moZYXkCzUraMbo8neevW1vAoWd0y8CLFKZKRRvgveP6rMjgz
        kxRWeJ5IGB1j/ZmMFcJnlOg20RB4R+0Ip6pDTtohUZnSoThY+SdFOrc4LuCSrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1692124835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJjeneACakyjixftgTs3skIu5CB0b3rHbi9cca9HEnA=;
        b=sgEX+zMm0KwH5JY6kJgT6JypLxG8sTkznUdSMrwnfUCaGP1xTGHOP9NCtS7QEUa9ysWs/G
        eMkpfm+idxNpqwLrb6hswiFK5FVm3lvnil0Kqogs1VjIGy4attoobcwjdlwBI2qCvOwZog
        wWc5c9uoG/93WxGNxPZx+heYgB/hq914XiFswmtTuttvv17i1KikCisEAPDcR8vUPMA5wc
        N6fab/v2FGj4GEPFsTUwrK+I0XONhI7gIuLztzYtGtlz9lyur+bQCfoBl3uh3zQw87WHrG
        t4CUhZ8VpcVfXn4a4j+xYdYfWgRI5MPSydj4o9F9JrNceITChMTc1VqqcCJ+dQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1692124835; a=rsa-sha256;
        cv=none;
        b=P7ahnPAeRIxx8jwOwFDl4P4LAVclIrqIsNrDQd9Dbu40taISzxiwSS3jHpGXNj63wCNqek
        UIJoUJ+2VFcCQVxwOZEbU3Rk38rx/EFd+pcT4UCH2dxED0G8V2eQyT3GDuC8kkggJ3u+H4
        lQi4q2Gb8n+yBz076+VBcvrk50DzminobmKIXq+yLpckXuTrRcGrZ6thDpCV5/qoE/bjux
        NE8hYVfRAaQiVlZvYuEtlsfSEM4ZBt5/pfipOYDBSH4uyfuVgYA7qDWV7CCblzHDIRWJ6w
        hIGtX/hFRzqQJHacVAZTu0SnspOd4/zvsBLejGAcBb3+KrDExvFZwgQTYKTXKQ==
From:   Paulo Alcantara <pc@manguebit.com>
To:     Scott Mayhew <smayhew@redhat.com>,
        Steve French <sfrench@samba.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>
Cc:     Steve French <stfrench@microsoft.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        Scott Mayhew <smayhew@redhat.com>
Subject: Re: [PATCH] smb: client: fix null auth
In-Reply-To: <20230815-fix-cifs-null-auth-v1-1-3cb785216d97@redhat.com>
References: <20230815-fix-cifs-null-auth-v1-1-3cb785216d97@redhat.com>
Date:   Tue, 15 Aug 2023 15:40:31 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Mayhew <smayhew@redhat.com> writes:

> Commit abdb1742a312 removed code that clears ctx->username when
> sec=none, so attempting to mount with '-o sec=none' now fails with
> -EACCES.  Fix it by adding that logic to the parsing of the 'sec'
> option, as well as checking if the mount is using null auth before
> setting the username when parsing the 'user' option.
>
> Fixes: abdb1742a312 ("cifs: get rid of mount options string parsing")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  fs/smb/client/fs_context.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
