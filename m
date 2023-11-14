Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B877F7EB03D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjKNMwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjKNMwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:52:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B55D196
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699966318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ebvZe4TIPBxRze+Pu3P24AV1eNd9MQIB23VhEMldQz0=;
        b=J/HaAVEV7UMll6/AHstFy4ughVE9qi57YFIb6vFJL/dVLVCA9bJQY3ltOXSN8CFXI2OCFV
        UWkt3BPL4SBOUEU0M+RX9UKeM/ZeePzDBoJp2T/0CxKvfMhXohPe0pCeODqTY9WFEoM63c
        IADkLNElszp8Ken9HX4cCwdwcbbT1qc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-Znp_XnGwOXuaeN0YZOHPww-1; Tue,
 14 Nov 2023 07:51:54 -0500
X-MC-Unique: Znp_XnGwOXuaeN0YZOHPww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7C261C05149;
        Tue, 14 Nov 2023 12:51:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B3D72026D4C;
        Tue, 14 Nov 2023 12:51:51 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jtornosm@redhat.com, weihao.bj@ieisystem.com
Subject: [PATCH 0/2] net: usb: ax88179_178a: fix and improve reset procedure
Date:   Tue, 14 Nov 2023 13:50:43 +0100
Message-ID: <20231114125111.313229-1-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intensive reset testing has detected some problems that need to be fixed
to get a correct initialization.

