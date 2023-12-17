Return-Path: <linux-kernel+bounces-2614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFFF815F79
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB351C21039
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFC444C6F;
	Sun, 17 Dec 2023 13:41:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E498444390;
	Sun, 17 Dec 2023 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 8AAC912093F;
	Sun, 17 Dec 2023 13:41:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 0A79119;
	Sun, 17 Dec 2023 13:41:13 +0000 (UTC)
Message-ID: <9a9e84bf64fc95840ff852aeb276ef8f724b60be.camel@perches.com>
Subject: Re: [PATCH v3] iio: sx9324: avoid copying property strings
From: Joe Perches <joe@perches.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Stephen Boyd <swboyd@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
Date: Sun, 17 Dec 2023 05:41:12 -0800
In-Reply-To: <20231217132447.269072df@jic23-huawei>
References: 
	<20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com>
	 <f03d372a282712dee8412e47aff9bb54f181efd9.camel@perches.com>
	 <20231217132447.269072df@jic23-huawei>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0A79119
X-Rspamd-Server: rspamout02
X-Stat-Signature: 55tnysbjs4z59qdfgqwosyw5fpsji5rr
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18MlYf/abwYr5NYDUmr9xoyL4oUIp2C6bk=
X-HE-Tag: 1702820473-749084
X-HE-Meta: U2FsdGVkX1+WnYfaK4UJSBADr2dzH257oYCOZo1NLbbRbYYcM4iIJQPWtrMU2oAIhYVMaYlxk/Nj0EN783k1SW80vlTxDq2AyiK4wyVlt8bygUTvw5Q3BmgmAtF4/o85pkBijx2hb/d3RX6AUxCyMUCjaNIGbtam/IjL8yZS+teN+4B+ifjmZDFQBLlrMOuJB1itaX5mXG/62dNwn5oGi2DmceDzTHYRQgB9+fthoUes3Rl8+mEAYjC6Jx6Vog6B/xdgnUZhrjsQpabWXizpKCB4Pa8R7PrzjbFLVAcjJj1+o4VYH/YlQaTUVuVbERGbJ4gwH3RFnWhzUf/cLqs1JHzhTw/nu19HuCGw6imuHnPvMC0Y/eu6Lo4zSkkByMVZ

On Sun, 2023-12-17 at 13:24 +0000, Jonathan Cameron wrote:
> On Mon, 11 Dec 2023 22:30:12 -0800
> Joe Perches <joe@perches.com> wrote:
>=20
> > On Tue, 2023-12-12 at 00:42 +0000, Justin Stitt wrote:
> > > We're doing some needless string copies when trying to assign the pro=
per
> > > `prop` string. We can make `prop` a const char* and simply assign to
> > > string literals. =20
> >=20
> > trivia:
> >=20
> > I would have updated it like this moving the
> > various declarations into the case blocks
> > where they are used and removing a few unused
> > #defines
>=20
> I'd definitely like to see those defines gone.
> Arguably an unrelated change as I guess they are left from a previous ref=
actor
> of this code.
>=20
> Why prop to type renaming?

random, no specific need, though I prefer not reusing
identifiers with different types in separate local scopes.

>   It's getting passed into calls where the parameter
> is propname so I'd understand renaming to that, but type just seems a bit=
 random
> to me.  I do wonder if we are better off having some long lines and getti=
ng rid
> of the property naming local variables completely by just duplicating
> the device_property_read_u32() call and passing them in directly.

maybe, give it a try and see what you think.


