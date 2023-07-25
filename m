Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C1C76201F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjGYR3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjGYR3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:29:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB38A193
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690306102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQw9Ser+M2NE25R1fRsh+0Ukg8sPQALOL3L++smDxxc=;
        b=OHSpEy3kbd2Q2X9jS9Z3v4UrId4x/stnMIXXjWJaXY9JJBiCmg4AnowvWCj/jVNJrQddeb
        MllVB3ES+Cc1v4E7iKI04zkqUAVSQlCTv5+0tKLegPVXwK6Nn0Il62rt9V1Z+e56GvD9mA
        v2jLKXnvOQ9fkZM/oUL9ROAc6uyo1NM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-MUm7GKFWOkie7bp6JrBFpw-1; Tue, 25 Jul 2023 13:28:15 -0400
X-MC-Unique: MUm7GKFWOkie7bp6JrBFpw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5442438149A3;
        Tue, 25 Jul 2023 17:28:15 +0000 (UTC)
Received: from rhel-developer-toolbox-latest (unknown [10.2.16.250])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8266840C2063;
        Tue, 25 Jul 2023 17:28:14 +0000 (UTC)
Date:   Tue, 25 Jul 2023 10:28:12 -0700
From:   Chris Leech <cleech@redhat.com>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] scsi: qla4xxx: Add length check when paring nlattrs
Message-ID: <ZMAGLLkaNMpy7jXS@rhel-developer-toolbox-latest>
References: <20230723080053.3714534-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723080053.3714534-1-linma@zju.edu.cn>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

On Sun, Jul 23, 2023 at 04:00:53PM +0800, Lin Ma wrote:
> There are three places that qla4xxx looply parses nlattrs
> * qla4xxx_set_chap_entry(...)
> * qla4xxx_iface_set_param(...)
> * qla4xxx_sysfs_ddb_set_param(...)
> and each of them directly converts the nlattr to specific pointer of
> structure without length checking. This could be dangerous as those
> attributes are not validated before and a malformed nlattr (e.g., length
> 0) could result in an OOB read that leaks heap dirty data.
> 
> This patch adds the nla_len check before accessing the nlattr data and
> error return EINVAL if the length check fails.

Reviewed-by: Chris Leech <cleech@redhat.com>

